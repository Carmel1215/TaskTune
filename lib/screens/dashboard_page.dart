import 'package:flutter/material.dart';

// 할 일 데이터 모델: fatigue 타입을 int로 유지 (1-100)
class ToDo {
  final String text;
  bool isDone;
  final int fatigue; // AI가 측정한 피로도 (1 ~ 100%)

  ToDo({
    required this.text,
    this.isDone = false,
    required this.fatigue,
  });
}

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final TextEditingController _todoController = TextEditingController();
  final List<ToDo> _todos = [];

  // 1. "AI" 피로도 분석 로직 고도화
  int _calculateFatigue(String text) {
    // 키워드와 피로도 점수 맵핑
    const Map<String, int> fatigueKeywords = {
      // 높은 정신적 피로 (80-95점)
      '과제': 95,
      '프로젝트': 95,
      '시험': 90,
      '논문': 90,
      '발표': 88,
      '코딩': 85,
      '공부': 80,
      '기획': 82,
      // 높은 신체적 피로 (70-85점)
      '헬스': 85, '운동': 80, '등산': 82, '달리기': 75, '이사': 90,
      // 중간 피로 (40-65점)
      '청소': 65, '요리': 55, '장보기': 50, '정리': 60, '운전': 45, '회의': 60,
      // 낮은 피로 (10-35점)
      '산책': 35, '독서': 30, '영화': 20, '음악': 15, '휴식': 10, '친구': 30,
    };

    // 강조 부사 가중치
    const Map<String, int> intensifiers = {
      '매우': 20,
      '중요한': 18,
      '긴급': 25,
      '많이': 15,
      '열심히': 15,
    };

    int maxFatigue = 0; // 기본 피로도
    int intensityBonus = 0;

    // 1. 핵심 활동의 피로도 찾기 (가장 높은 점수로)
    fatigueKeywords.forEach((keyword, score) {
      if (text.contains(keyword)) {
        if (score > maxFatigue) {
          maxFatigue = score;
        }
      }
    });

    // 2. 강조 부사에 따른 보너스 점수 추가
    intensifiers.forEach((keyword, score) {
      if (text.contains(keyword)) {
        intensityBonus += score;
      }
    });

    // 할 일 텍스트가 있지만 키워드가 없는 경우, 기본 피로도 25로 설정
    if (maxFatigue == 0) {
      maxFatigue = 25;
    }

    // 최종 피로도 계산 (기본 피로도 + 강조 보너스)
    int finalFatigue = maxFatigue + intensityBonus;

    // 결과값을 1% ~ 100% 사이로 보정
    return finalFatigue.clamp(1, 100);
  }

  void _addTodo() {
    final text = _todoController.text.trim();
    if (text.isNotEmpty) {
      setState(() {
        final fatigue = _calculateFatigue(text);
        _todos.add(ToDo(text: text, fatigue: fatigue));
        _todoController.clear();
      });
    }
  }

  void _toggleTodoStatus(int index) {
    setState(() {
      _todos[index].isDone = !_todos[index].isDone;
    });
  }

  // 3. 지능화된 미니 통계 카드 위젯
  Widget _buildStatsCardBody() {
    if (_todos.isEmpty) {
      return const Center(child: Text("AI가 할 일의 피로도 기반으로 통계를 제공합니다."));
    }

    final bool allDone = _todos.every((todo) => todo.isDone);

    if (allDone) {
      // 모든 할 일을 완료했을 때: 평균 피로도 기반 AI 피드백
      double totalFatigue = _todos.fold(0, (sum, item) => sum + item.fatigue);
      double averageFatigue = totalFatigue / _todos.length;
      String feedbackMessage;

      if (averageFatigue > 75) {
        feedbackMessage = "오늘은 정말 고된 하루였네요! 대단하십니다. 충분한 휴식으로 꼭 재충전하세요. 🔋";
      } else if (averageFatigue > 40) {
        feedbackMessage = "알찬 하루를 보내셨군요! 오늘의 노력 덕분에 내일은 더 가벼울 거예요. 멋져요! ✨";
      } else {
        feedbackMessage = "가벼운 일들을 모두 마치셨네요. 오늘 하루도 수고하셨습니다! 편안한 저녁 보내세요. 😊";
      }

      return Center(
        child: Text(
          feedbackMessage,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
      );
    } else {
      // 아직 할 일이 남았을 때: 피로도 높은 순 우선순위 리스트
      final remainingTodos = _todos.where((todo) => !todo.isDone).toList();
      remainingTodos.sort((a, b) => b.fatigue.compareTo(a.fatigue));

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "피로도 높은 순서 (우선순위):",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          const SizedBox(height: 8),
          ...remainingTodos.map(
            (todo) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: Text(
                "• ${todo.text} (피로도: ${todo.fatigue}%)",
                style: const TextStyle(fontSize: 14),
              ),
            ),
          ),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _DashBoardCard(
                title: '오늘의 할일',
                icon: Icons.calendar_today_rounded,
                body: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _todoController,
                            decoration: const InputDecoration(
                              hintText: '할 일을 입력하세요 (예: 중요한 프로젝트 기획)',
                              border: UnderlineInputBorder(),
                            ),
                            onSubmitted: (_) => _addTodo(),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.add_circle_outline),
                          onPressed: _addTodo,
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    _todos.isEmpty
                        ? const Padding(
                            padding: EdgeInsets.symmetric(vertical: 16.0),
                            child: Text(
                              '할 일을 추가해주세요.',
                              style: TextStyle(color: Colors.grey),
                            ),
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: _todos.length,
                            itemBuilder: (context, index) {
                              final todo = _todos[index];
                              return ListTile(
                                leading: IconButton(
                                  icon: Icon(
                                    todo.isDone
                                        ? Icons.check_circle
                                        : Icons.check_circle_outline,
                                    color: todo.isDone
                                        ? Colors.green
                                        : Colors.grey,
                                  ),
                                  onPressed: () => _toggleTodoStatus(index),
                                ),
                                title: Text(
                                  todo.text,
                                  style: TextStyle(
                                    decoration: todo.isDone
                                        ? TextDecoration.lineThrough
                                        : TextDecoration.none,
                                    color: todo.isDone
                                        ? Colors.grey
                                        : Colors.black87,
                                  ),
                                ),
                                // 2. 각 항목에 예상 피로도 표시
                                subtitle: Text(
                                  '예상 피로도: ${todo.fatigue}%',
                                  style: TextStyle(
                                    color: todo.isDone
                                        ? Colors.grey
                                        : Colors.blueGrey,
                                  ),
                                ),
                                trailing: IconButton(
                                  icon: const Icon(Icons.delete_outline),
                                  onPressed: () {
                                    setState(() {
                                      _todos.removeAt(index);
                                    });
                                  },
                                ),
                              );
                            },
                          ),
                  ],
                ),
              ),
              _DashBoardCard(
                title: '미니 통계',
                icon: Icons.bar_chart_rounded,
                body: _buildStatsCardBody(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// _DashBoardCard 위젯은 수정할 필요 없습니다.
class _DashBoardCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget body;

  const _DashBoardCard({
    required this.title,
    required this.icon,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Icon(icon),
                const SizedBox(width: 10),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const Divider(),
            body,
          ],
        ),
      ),
    );
  }
}
