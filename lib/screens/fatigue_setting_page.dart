import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:openai_dart/openai_dart.dart';
import 'package:tasktune/env/env.dart';
import 'package:tasktune/data/app_state.dart';
import 'package:tasktune/api/fatigue_api.dart';

final _client = OpenAIClient(apiKey: Env.apiKey);
final _fatigueApi = FatigueApi('http://localhost:8000');

/// OpenAI(gpt-4o-mini)로 활동명 → MET 추정(JSON {"met": number})
Future<double> _estimateMet(String activity) async {
  // 1) MET 테이블을 함수-툴로 주입
  const function = FunctionObject(
    name: 'set_activity_mets',
    description: '활동별 MET 테이블을 모델에 주입합니다.',
    parameters: {
      "type": "object",
      "properties": {
        "items": {
          "type": "array",
          "items": {
            "type": "object",
            "properties": {
              "activity": {"type": "string"},
              "met": {"type": "number"},
            },
            "required": ["activity", "met"],
          },
        },
      },
      "required": ["items"],
    },
  );
  const tool = ChatCompletionTool(
    type: ChatCompletionToolType.function,
    function: function,
  );

  final res1 = await _client.createChatCompletion(
    request: CreateChatCompletionRequest(
      model: const ChatCompletionModel.model(ChatCompletionModels.gpt4oMini),
      messages: const [
        ChatCompletionMessage.developer(
          content: ChatCompletionDeveloperMessageContent.text(
            'Load MET table, then answer user query.',
          ),
        ),
      ],
      tools: [tool],
      toolChoice: ChatCompletionToolChoiceOption.tool(
        ChatCompletionNamedToolChoice(
          type: ChatCompletionNamedToolChoiceType.function,
          function: ChatCompletionFunctionCallOption(name: function.name),
        ),
      ),
    ),
  );
  final toolCall = res1.choices.first.message.toolCalls?.first;
  if (toolCall == null) return 0.0;

  // 간단한 내장 테이블(폴백/보조). 필요시 확장 가능.
  const miniMetTable = [
    {"activity": "달리기 9km/h", "met": 9.4},
    {"activity": "달리기 8km/h", "met": 8.0},
    {"activity": "조깅", "met": 7.0},
    {"activity": "등산", "met": 6.0},
    {"activity": "자전거(보통)", "met": 7.2},
    {"activity": "계단 오르기", "met": 8.8},
    {"activity": "수영(보통)", "met": 5.8},
  ];

  // 2) JSON 모드로 숫자만
  final res2 = await _client.createChatCompletion(
    request: CreateChatCompletionRequest(
      model: const ChatCompletionModel.model(ChatCompletionModels.gpt4oMini),
      responseFormat: const ResponseFormat.jsonObject(),
      messages: [
        const ChatCompletionMessage.developer(
          content: ChatCompletionDeveloperMessageContent.text(
            'You are a MET estimation model. Use the loaded MET table if relevant. Return only valid JSON: {"met": <number>}.',
          ),
        ),
        ChatCompletionMessage.assistant(
          toolCalls: res1.choices.first.message.toolCalls,
        ),
        ChatCompletionMessage.tool(
          content: jsonEncode({'items': miniMetTable}),
          toolCallId: toolCall.id,
        ),
        ChatCompletionMessage.user(
          content: ChatCompletionUserMessageContent.string(
            'Estimate the MET value for "$activity". Return as {"met": <number>}.',
          ),
        ),
      ],
    ),
  );

  final content = res2.choices.first.message.content?.toString() ?? '{}';
  try {
    final data = jsonDecode(content) as Map<String, dynamic>;
    final m = (data['met'] ?? 0).toString();
    return double.tryParse(m)?.clamp(0.0, 30.0) ?? 0.0;
  } catch (_) {
    return 0.0;
  }
}

/// 설문 항목 모델
class _SurveyItem {
  _SurveyItem({
    required this.title,
    this.enabled = false,
    this.minutes = 0,
    this.met,
    this.fatigue,
  });

  final String title;
  bool enabled;
  int minutes; // 하루 가능 분량(분)
  double? met; // 불러온 MET
  double? fatigue; // FastAPI 예측 피로도
}

class FatigueSettingPage extends StatefulWidget {
  const FatigueSettingPage({super.key});

  @override
  State<FatigueSettingPage> createState() => _FatigueSettingPageState();
}

class _FatigueSettingPageState extends State<FatigueSettingPage> {
  final _items = <_SurveyItem>[
    _SurveyItem(title: '달리기 9km/h'),
    _SurveyItem(title: '등산'),
    _SurveyItem(title: '자전거'),
    _SurveyItem(title: '계단 오르기'),
    _SurveyItem(title: '수영'),
  ];

  bool _busyFetch = false;
  bool _busySave = false;

  double get _sumFatigue => _items
      .where((e) => e.enabled)
      .fold(0.0, (s, e) => s + (e.fatigue ?? 0.0));

  Future<void> _fetchMetAndPreviewFatigue() async {
    if (_busyFetch) return;
    setState(() => _busyFetch = true);

    try {
      // 선택된 항목만 처리
      final targets = _items.where((e) => e.enabled && e.minutes > 0).toList();

      for (final it in targets) {
        // 1) MET
        final met = await _estimateMet(it.title);
        it.met = met;

        // 2) 피로도 미리보기 (FastAPI)
        // preference는 설문 기반이 아니므로 중립값(0.5) 사용
        final fatigue = await _fatigueApi.predictFatigue(
          met: met,
          durationMin: it.minutes,
          preference01: 0.5,
        );
        it.fatigue = fatigue;

        if (!mounted) return;
        setState(() {});
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('불러오기 중 오류가 발생했어요: $e')),
      );
    } finally {
      if (mounted) setState(() => _busyFetch = false);
    }
  }

  Future<void> _saveCapacity() async {
    if (_busySave) return;

    final enabled = _items.where((e) => e.enabled && e.minutes > 0).toList();
    if (enabled.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('선택된 항목이 없어요. 항목을 켜고 시간을 입력해 주세요.')),
      );
      return;
    }

    // 아직 미리보기 계산 안 된 항목이 있으면 먼저 계산
    final needCalc = enabled
        .where((e) => e.fatigue == null || e.met == null)
        .toList();
    if (needCalc.isNotEmpty) {
      await _fetchMetAndPreviewFatigue();
    }

    final sum = _sumFatigue;
    if (sum <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('계산 결과가 0이에요. 시간을 조정하거나 다시 시도해 주세요.')),
      );
      return;
    }

    setState(() => _busySave = true);
    try {
      final app = context.read<AppState>();
      app.updateDailyFatigueCapacity(sum);

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('최대 일일 피로도 ${sum.toStringAsFixed(1)}로 저장했어요.')),
      );

      // ✅ 화면 전환/복귀 없이 끝! (Navigator.pop 제거)
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('저장 중 오류가 발생했어요: $e')),
      );
    } finally {
      if (mounted) setState(() => _busySave = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final capPreview = _sumFatigue;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // 설문 카드들
        ..._items.map((it) {
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  SwitchListTile(
                    title: Text(
                      it.title,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    value: it.enabled,
                    onChanged: (v) => setState(() => it.enabled = v),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Text('하루 가능 시간'),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Slider(
                          value: it.minutes.toDouble(),
                          min: 0,
                          max: 120,
                          divisions: 24,
                          label: '${it.minutes}분',
                          onChanged: it.enabled
                              ? (v) => setState(() => it.minutes = v.round())
                              : null,
                        ),
                      ),
                      SizedBox(
                        width: 64,
                        child: Text(
                          '${it.minutes}분',
                          textAlign: TextAlign.right,
                          style: const TextStyle(
                            fontFeatures: [FontFeature.tabularFigures()],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'MET: ${it.met?.toStringAsFixed(1) ?? '-'}'
                          '  ·  피로도: ${it.fatigue?.toStringAsFixed(1) ?? '-'}',
                          style: TextStyle(color: Colors.grey.shade800),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }),

        const SizedBox(height: 12),
        // 하단 요약 + 버튼들
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  '예상 최대 피로도 합계: ${capPreview.toStringAsFixed(1)}',
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(width: 8),
              FilledButton.icon(
                onPressed: _busyFetch ? null : _fetchMetAndPreviewFatigue,
                icon: _busyFetch
                    ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.auto_awesome),
                label: const Text('MET 불러오기'),
              ),
              const SizedBox(width: 8),
              FilledButton.icon(
                onPressed: _busySave ? null : _saveCapacity,
                icon: _busySave
                    ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.save_rounded),
                label: const Text('저장'),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}
