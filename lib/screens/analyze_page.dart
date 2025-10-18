import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:openai_dart/openai_dart.dart';
import 'package:tasktune/env/env.dart';

final client = OpenAIClient(apiKey: Env.apiKey);

const metTable = [
  // TODO: JSON 파일 따로 분리하고 읽어오는 시스템 만들기
  {"activity": "수면", "met": 0.95},
  {"activity": "명상", "met": 1.0},
  {"activity": "앉아서 TV 시청", "met": 1.3},
  {"activity": "전화 통화하기", "met": 1.3},
  {"activity": "컴퓨터 작업", "met": 1.3},
  {"activity": "앉아 공부하기", "met": 1.3},
  {"activity": "독서", "met": 1.3},
  {"activity": "TV시청", "met": 1.3},
  {"activity": "앉아서 대화하기", "met": 1.3},
  {"activity": "앉기", "met": 1.3},
  {"activity": "비누칠하기", "met": 1.3},
  {"activity": "바느질하기", "met": 1.3},
  {"activity": "보드게임 하기", "met": 1.5},
  {"activity": "사무직", "met": 1.5},
  {"activity": "잔디에 물 주기", "met": 1.5},
  {"activity": "기도", "met": 1.5},
  {"activity": "식사하기", "met": 1.5},
  {"activity": "체스 두기", "met": 1.5},
  {"activity": "설거지", "met": 1.8},
  {"activity": "다림질", "met": 1.8},
  {"activity": "서서 이야기하기", "met": 1.8},
  {"activity": "서서 듣기", "met": 1.8},
  {"activity": "미용실 가기", "met": 1.8},
  {"activity": "화장하기", "met": 1.8},
  {"activity": "교회 예배", "met": 2.0},
  {"activity": "절", "met": 2.0},
  {"activity": "성당 예배", "met": 2.0},
  {"activity": "빨래하기", "met": 2.0},
  {"activity": "얼음낚시", "met": 2.0},
  {"activity": "아주 느린 걷기", "met": 2.0},
  {"activity": "나디쇼다나 요가", "met": 2.0},
  {"activity": "낚시", "met": 2.0},
  {"activity": "설거지하기", "met": 2.1},
  {"activity": "요리준비하기", "met": 2.1},
  {"activity": "요리하기", "met": 2.1},
  {"activity": "빨래 걷기", "met": 2.1},
  {"activity": "빨래 널기", "met": 2.1},
  {"activity": "빨래 접기", "met": 2.1},
  {"activity": "세탁기 이용", "met": 2.1},
  {"activity": "건조기 이용", "met": 2.1},
  {"activity": "피아노 연주", "met": 2.2},
  {"activity": "플루트 연주", "met": 2.2},
  {"activity": "스트레칭", "met": 2.3},
  {"activity": "옷 입기", "met": 2.3},
  {"activity": "양치", "met": 2.3},
  {"activity": "머리 손질", "met": 2.3},
  {"activity": "세수", "met": 2.3},
  {"activity": "먼지 털기", "met": 2.3},
  {"activity": "식료품 쇼핑", "met": 2.3},
  {"activity": "걷기(천천히)", "met": 2.3},
  {"activity": "판매원", "met": 2.3},
  {"activity": "하타 요가", "met": 2.5},
  {"activity": "쓰레기 버리기", "met": 2.5},
  {"activity": "요가", "met": 2.5},
  {"activity": "목욕하기", "met": 2.5},
  {"activity": "샤워하기", "met": 2.5},
  {"activity": "캠핑", "met": 2.5},
  {"activity": "서 있기", "met": 2.5},
  {"activity": "제설 작업", "met": 2.5},
  {"activity": "식료품 정리", "met": 2.5},
  {"activity": "사냥(활)", "met": 2.5},
  {"activity": "화초 물주기", "met": 2.5},
  {"activity": "자동차 운전", "met": 2.5},
  {"activity": "청소하기", "met": 2.7},
  {"activity": "청소기 돌리기", "met": 2.7},
  {"activity": "식사준비", "met": 2.7},
  {"activity": "요리준비", "met": 2.7},
  {"activity": "음식 나르기", "met": 2.7},
  {"activity": "쓰레기 버리기", "met": 2.7},
  {"activity": "정리정돈하기", "met": 2.7},
  {"activity": "아이 돌보기", "met": 2.7},
  {"activity": "기저귀 갈기", "met": 2.7},
  {"activity": "아기 안기", "met": 2.7},
  {"activity": "느린 걷기", "met": 2.8},
  {"activity": "걷기(3.2km/h)", "met": 3.0},
  {"activity": "느린 춤", "met": 3.0},
  {"activity": "개 산책시키기", "met": 3.0},
  {"activity": "못질하기", "met": 3.0},
  {"activity": "가벼운 정원일", "met": 3.0},
  {"activity": "필라테스", "met": 3.0},
  {"activity": "다이빙", "met": 3.0},
  {"activity": "창문 닦기", "met": 3.2},
  {"activity": "이불 털기", "met": 3.3},
  {"activity": "침대 정리", "met": 3.3},
  {"activity": "빨래 널기", "met": 3.3},
  {"activity": "쓸기", "met": 3.3},
  {"activity": "내리막 걷기", "met": 3.3},
  {"activity": "저녁 요리", "met": 3.3},
  {"activity": "침대 정리", "met": 3.3},
  {"activity": "청소기 돌리기", "met": 3.3},
  {"activity": "기타 연주", "met": 3.4},
  {"activity": "드럼 연주", "met": 3.4},
  {"activity": "바이올린 연주", "met": 3.4},
  {"activity": "요리사", "met": 3.4},
  {"activity": "바리스타", "met": 3.4},
  {"activity": "스쿼트 머신 사용", "met": 3.5},
  {"activity": "낚시", "met": 3.5},
  {"activity": "걸레질", "met": 3.5},
  {"activity": "보통 속도로 걷기", "met": 3.5},
  {"activity": "자전거 타기(시속 5.5mph)", "met": 3.5},
  {"activity": "차고 청소", "met": 3.5},
  {"activity": "개 목욕시키기", "met": 3.5},
  {"activity": "송풍기 사용", "met": 3.5},
  {"activity": "중간 속도로 걷기", "met": 3.5},
  {"activity": "울타리 만들기", "met": 3.8},
  {"activity": "체조", "met": 3.8},
  {"activity": "대청소", "met": 3.8},
  {"activity": "카펫 청소", "met": 3.8},
  {"activity": "창문 닦기", "met": 3.8},
  {"activity": "마당 청소", "met": 3.8},
  {"activity": "정원일 하기", "met": 3.8},
  {"activity": "눈 쓸기", "met": 3.8},
  {"activity": "세차하기", "met": 3.8},
  {"activity": "바닥 문지르기", "met": 3.8},
  {"activity": "걷기(4.8km/h)", "met": 3.8},
  {"activity": "낙엽 긁기", "met": 3.8},
  {"activity": "볼링", "met": 3.8},
  {"activity": "배구", "met": 4.0},
  {"activity": "탁구", "met": 4.0},
  {"activity": "나무 다듬기", "met": 4.0},
  {"activity": "보트 타기", "met": 4.0},
  {"activity": "배구", "met": 4.0},
  {"activity": "컬링", "met": 4.0},
  {"activity": "서킷 트레이닝", "met": 4.3},
  {"activity": "골프(걷기 포함)", "met": 4.3},
  {"activity": "빠른 걷기", "met": 4.3},
  {"activity": "느린 계단 오르기", "met": 4.4},
  {"activity": "정원 잡초 제거", "met": 4.5},
  {"activity": "게잡이", "met": 4.5},
  {"activity": "장작 패기", "met": 4.5},
  {"activity": "나무 심기", "met": 4.5},
  {"activity": "카펫 제거", "met": 4.5},
  {"activity": "나무 자르기", "met": 4.5},
  {"activity": "잔디 깎기", "met": 4.5},
  {"activity": "노 젓기(고정식)", "met": 4.8},
  {"activity": "물건 나르기", "met": 4.8},
  {"activity": "무거운 짐 옮기기", "met": 4.8},
  {"activity": "탭댄스", "met": 4.8},
  {"activity": "골프", "met": 4.8},
  {"activity": "크리켓", "met": 4.8},
  {"activity": "걷기(6.4km/h)", "met": 4.9},
  {"activity": "스케이트보드", "met": 5.0},
  {"activity": "홈통 청소", "met": 5.0},
  {"activity": "발레", "met": 5.0},
  {"activity": "야구", "met": 5.0},
  {"activity": "일립티컬 머신", "met": 5.0},
  {"activity": "외발자전거 타기", "met": 5.0},
  {"activity": "부트캠프 훈련", "met": 5.0},
  {"activity": "테니스(복식)", "met": 5.0},
  {"activity": "저강도 에어로빅", "met": 5.0},
  {"activity": "잔디 깔기", "met": 5.0},
  {"activity": "야구", "met": 5.0},
  {"activity": "소프트볼", "met": 5.0},
  {"activity": "보통 제설작업", "met": 5.3},
  {"activity": "수중 에어로빅", "met": 5.3},
  {"activity": "사교댄스", "met": 5.5},
  {"activity": "승마", "met": 5.5},
  {"activity": "배드민턴", "met": 5.5},
  {"activity": "계단 에어로빅(10cm)", "met": 5.5},
  {"activity": "잔디 깎기", "met": 5.5},
  {"activity": "저항 밴드 스쿼트", "met": 5.5},
  {"activity": "행진밴드", "met": 5.5},
  {"activity": "수영(보통 속도)", "met": 5.8},
  {"activity": "계단 오르기", "met": 5.8},
  {"activity": "빨래 들고 오르기", "met": 5.8},
  {"activity": "노 젓기(보통)", "met": 5.8},
  {"activity": "피구", "met": 5.8},
  {"activity": "자전거 타기(시속 9.4mph)", "met": 5.8},
  {"activity": "가구 옮기기", "met": 5.8},
  {"activity": "벤치프레스", "met": 6.0},
  {"activity": "치어리딩", "met": 6.0},
  {"activity": "등산(보통)", "met": 6.0},
  {"activity": "느린 수영", "met": 6.0},
  {"activity": "자동차 수리", "met": 6.0},
  {"activity": "레슬링", "met": 6.0},
  {"activity": "수상스키", "met": 6.0},
  {"activity": "펜싱", "met": 6.0},
  {"activity": "데드리프트", "met": 6.0},
  {"activity": "강도 높은 정원일", "met": 6.0},
  {"activity": "제설", "met": 6.0},
  {"activity": "재즈댄스", "met": 6.0},
  {"activity": "웨이트 트레이닝", "met": 6.0},
  {"activity": "조깅/걷기 혼합", "met": 6.0},
  {"activity": "크로스컨트리 하이킹", "met": 6.0},
  {"activity": "건설노동", "met": 6.2},
  {"activity": "강하게 장작 패기", "met": 6.3},
  {"activity": "언덕 오르기", "met": 6.3},
  {"activity": "농구", "met": 6.5},
  {"activity": "농구(연습)", "met": 6.5},
  {"activity": "줌바", "met": 6.5},
  {"activity": "자전거 타기(시속 10-11.9mph)", "met": 6.8},
  {"activity": "오르막 걷기(6.4km/h)", "met": 6.8},
  {"activity": "스키머신", "met": 6.8},
  {"activity": "느린 크로스컨트리 스키", "met": 6.8},
  {"activity": "고정식 자전거", "met": 7.0},
  {"activity": "제트스키", "met": 7.0},
  {"activity": "롤러스케이팅", "met": 7.0},
  {"activity": "조깅", "met": 7.0},
  {"activity": "축구(가볍게)", "met": 7.0},
  {"activity": "스케이트", "met": 7.0},
  {"activity": "스키", "met": 7.0},
  {"activity": "수영(평영)", "met": 7.0},
  {"activity": "킥볼", "met": 7.0},
  {"activity": "백패킹", "met": 7.0},
  {"activity": "라켓볼", "met": 7.0},
  {"activity": "아이스 스케이팅", "met": 7.0},
  {"activity": "축구", "met": 7.0},
  {"activity": "스키", "met": 7.0},
  {"activity": "썰매 타기", "met": 7.0},
  {"activity": "자전거 타기(보통)", "met": 7.2},
  {"activity": "댄스(디스코, 라인댄스, 포크)", "met": 7.3},
  {"activity": "에어로빅", "met": 7.3},
  {"activity": "테니스(단식)", "met": 7.3},
  {"activity": "고강도 에어로빅", "met": 7.3},
  {"activity": "테니스", "met": 7.3},
  {"activity": "계단 에어로빅(15cm 이상)", "met": 7.5},
  {"activity": "강도 높은 제설작업", "met": 7.5},
  {"activity": "계단에서 짐 옮기기", "met": 7.5},
  {"activity": "라인댄스", "met": 7.8},
  {"activity": "필드하키", "met": 7.8},
  {"activity": "라크로스", "met": 8.0},
  {"activity": "싱크로나이즈드 수영", "met": 8.0},
  {"activity": "암벽등반", "met": 8.0},
  {"activity": "달리기(8km/h)", "met": 8.0},
  {"activity": "트레이너", "met": 8.0},
  {"activity": "농구(경기)", "met": 8.0},
  {"activity": "플래그 풋볼", "met": 8.0},
  {"activity": "제자리 조깅", "met": 8.0},
  {"activity": "자전거 타기(시속 12-13.9mph)", "met": 8.0},
  {"activity": "아이스하키", "met": 8.0},
  {"activity": "점프 스쿼트", "met": 8.0},
  {"activity": "12분/마일 달리기", "met": 8.3},
  {"activity": "럭비", "met": 8.3},
  {"activity": "BMX", "met": 8.5},
  {"activity": "스핀클래스", "met": 8.5},
  {"activity": "산악자전거", "met": 8.5},
  {"activity": "강도 높은 고정식 노젓기", "met": 8.5},
  {"activity": "빠른 계단 오르기", "met": 8.8},
  {"activity": "느린 줄넘기", "met": 8.8},
  {"activity": "크로스컨트리 달리기", "met": 9.0},
  {"activity": "등산(빠름)", "met": 9.0},
  {"activity": "농구 드릴", "met": 9.3},
  {"activity": "달리기(9.7km/h)", "met": 9.4},
  {"activity": "계단 에어로빅(25cm 이상)", "met": 9.5},
  {"activity": "케틀벨 스윙", "met": 9.8},
  {"activity": "빠른 수영", "met": 9.8},
  {"activity": "10분/마일 달리기", "met": 9.8},
  {"activity": "빠른 물장구치기", "met": 9.8},
  {"activity": "수영(자유형, 빠르게)", "met": 9.8},
  {"activity": "중간 속도 롤러블레이드", "met": 9.8},
  {"activity": "수구", "met": 10.0},
  {"activity": "자전거 타기(시속 14-15.9mph)", "met": 10.0},
  {"activity": "무게 착용 에어로빅(4~7kg)", "met": 10.0},
  {"activity": "달리기(10.8km/h)", "met": 10.2},
  {"activity": "축구(경기)", "met": 10.3},
  {"activity": "킥복싱", "met": 10.3},
  {"activity": "태권도", "met": 10.3},
  {"activity": "9분/마일 달리기", "met": 10.5},
  {"activity": "줄넘기", "met": 11.0},
  {"activity": "슬라이드 보드 운동", "met": 11.0},
  {"activity": "8분/마일 달리기", "met": 11.8},
  {"activity": "보통 속도 줄넘기", "met": 11.8},
  {"activity": "달리기(12.9km/h)", "met": 11.8},
  {"activity": "줄넘기(보통)", "met": 11.8},
  {"activity": "자전거 타기(시속 16-19mph)", "met": 12.0},
  {"activity": "아주 강한 고정식 노젓기", "met": 12.0},
  {"activity": "빠른 줄넘기", "met": 12.3},
  {"activity": "7분/마일 달리기", "met": 12.3},
  {"activity": "줄넘기(빠름)", "met": 12.3},
  {"activity": "빠른 롤러블레이드", "met": 12.3},
  {"activity": "강도 높은 카약", "met": 12.5},
  {"activity": "빠른 크로스컨트리 스키", "met": 12.5},
  {"activity": "복싱", "met": 12.8},
  {"activity": "달리기(16.1km/h)", "met": 12.8},
  {"activity": "복싱", "met": 12.8},
  {"activity": "마라톤", "met": 13.3},
  {"activity": "스피드 스케이팅", "met": 13.3},
  {"activity": "아이스댄싱", "met": 14.0},
  {"activity": "6분/마일 달리기", "met": 14.5},
  {"activity": "계단 달리기", "met": 15.0},
  {"activity": "자전거 타기(시속 20mph 이상)", "met": 15.8},
  {"activity": "5분/마일 달리기", "met": 19.0},
];

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

Future<String> estimateMet(String activity) async {
  // 툴 호출 강제
  final res1 = await client.createChatCompletion(
    request: CreateChatCompletionRequest(
      model: const ChatCompletionModel.model(ChatCompletionModels.gpt5),
      messages: [
        const ChatCompletionMessage.developer(
          content: ChatCompletionDeveloperMessageContent.text(
            'Load Met table, then answer user query.',
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
  if (toolCall == null) return '';

  final res2 = await client.createChatCompletion(
    request: CreateChatCompletionRequest(
      model: const ChatCompletionModel.model(ChatCompletionModels.gpt5),
      messages: [
        const ChatCompletionMessage.developer(
          content: ChatCompletionDeveloperMessageContent.text(
            'Load MET Table, then answer user query.',
          ),
        ),
        ChatCompletionMessage.assistant(
          toolCalls: res1.choices.first.message.toolCalls,
        ),
        ChatCompletionMessage.tool(
          content: jsonEncode({'items': metTable}),
          toolCallId: toolCall.id,
        ),
        ChatCompletionMessage.user(
          content: ChatCompletionUserMessageContent.string(
            'Estimate the MET value for "$activity". '
            'Return "<number> - <one sentence reason>".',
          ),
        ),
      ],
      tools: [tool],
    ),
  );

  return res2.choices.first.message.content?.toString() ?? '';
}

class AnalyzePage extends StatefulWidget {
  const AnalyzePage({super.key});
  @override
  State<AnalyzePage> createState() => _AnalyzePageState();
}

class _AnalyzePageState extends State<AnalyzePage> {
  final _c = TextEditingController();
  String _out = '';
  bool _busy = false;

  @override
  State<AnalyzePage> createState() => _AnalyzePageState();
}

class _AnalyzePageState extends State<AnalyzePage> {
  final TextEditingController _taskController = TextEditingController();
  final List<Task> _tasks = [];

  @override
  void dispose() {
    _taskController.dispose();
    super.dispose();
  }

  void _addTask(String title) {
    if (title.trim().isEmpty) return;
    setState(() {
      _tasks.add(Task(title.trim()));
      _taskController.clear();
    });
  }

  void _analyzeTask(int index) async {
    setState(() => _tasks[index].isAnalyzing = true);
    await Future.delayed(const Duration(seconds: 1)); // (백엔드 응답 대기 가정)
    setState(() {
      _tasks[index]
        ..isAnalyzing = false
        ..isAnalyzed = true
        ..progress = 35 + (index * 10) % 60 // 예시값
        ..analysisText = "이 작업은 ${_tasks[index].progress.toStringAsFixed(0)}%의 피로도를 보입니다.\n집중 시간을 조절해보세요.";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Analyze Page")),
      body: Column(
        children: [
          // 🔹 전체 피로도
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "전체 피로도",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                LinearProgressIndicator(
                  value: _tasks.isEmpty
                      ? 0
                      : _tasks
                              .map((t) => t.progress)
                              .fold<double>(0, (a, b) => a + b) /
                          (_tasks.length * 100),
                  minHeight: 10,
                  borderRadius: BorderRadius.circular(10),
                  backgroundColor: Colors.grey.shade300,
                  color: Colors.blueAccent,
                ),
              ],
            ),
          ),

          // 🔹 할 일 리스트 (카드형)
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _tasks.length,
              itemBuilder: (context, index) {
                final task = _tasks[index];
                return Card(
                  elevation: 3,
                  margin: const EdgeInsets.only(bottom: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 🔸 제목 + 버튼/퍼센트
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              task.title,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            task.isAnalyzed
                                ? Text(
                                    "(${task.progress.toStringAsFixed(0)}%)",
                                    style: const TextStyle(
                                      color: Colors.blueAccent,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                : OutlinedButton(
                                    onPressed: task.isAnalyzing
                                        ? null
                                        : () => _analyzeTask(index),
                                    style: OutlinedButton.styleFrom(
                                      side: const BorderSide(
                                          color: Colors.blueAccent, width: 1.5),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                    child: task.isAnalyzing
                                        ? const SizedBox(
                                            height: 16,
                                            width: 16,
                                            child: CircularProgressIndicator(
                                              strokeWidth: 2,
                                              color: Colors.blueAccent,
                                            ),
                                          )
                                        : const Text(
                                            "분석하기",
                                            style: TextStyle(
                                              color: Colors.blueAccent,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                  ),
                          ],
                        ),
                        const SizedBox(height: 12),

                        // 🔸 분석 결과 텍스트
                        if (task.isAnalyzed)
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              border: Border.all(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              task.analysisText,
                              style: const TextStyle(fontSize: 14),
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),

      // 🔹 하단 고정 입력창
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
        child: TextField(
          controller: _taskController,
          decoration: InputDecoration(
            hintText: "할 일 입력 후 Enter",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            suffixIcon: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Icon(
                Icons.keyboard_return_rounded,
                color: Colors.grey.shade500,
              ),
            ),
          ),
          onSubmitted: _addTask,
      appBar: AppBar(title: const Text('AI MET 추정')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _c,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: '활동 (예: 2km 등교)',
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: _busy
                  ? null
                  : () async {
                      final q = _c.text.trim();
                      if (q.isEmpty) return;
                      setState(() => _busy = true);
                      final r = await estimateMet(q);
                      setState(() {
                        _out = r;
                        _busy = false;
                      });
                    },
              child: Text(_busy ? '실행 중...' : '실행'),
            ),
            const SizedBox(height: 12),
            SelectableText(_out),
          ],
        ),
      ),
    );
  }
}

class Task {
  String title;
  double progress;
  bool isAnalyzed;
  bool isAnalyzing;
  String analysisText;

  Task(this.title)
      : progress = 0,
        isAnalyzed = false,
        isAnalyzing = false,
        analysisText = '';
}
