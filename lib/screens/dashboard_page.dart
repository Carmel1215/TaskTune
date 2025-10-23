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

  int _calculateFatigue(String text) {
    const Map<String, int> fatigueKeywords = {
      '과제': 95, '프로젝트': 95, '시험': 90, '논문': 90, '발표': 88,
      '코딩': 85, '공부': 80, '기획': 82,
      '헬스': 85, '운동': 80, '등산': 82, '달리기': 75, '이사': 90,
      '청소': 65, '요리': 55, '장보기': 50, '정리': 60, '운전': 45, '회의': 60,
      '산책': 35, '독서': 30, '영화': 20, '음악': 15, '휴식': 10, '친구': 30,
    };

    const Map<String, int> intensifiers = {
      '매우': 20, '중요한': 18, '긴급': 25, '많이': 15, '열심히': 15,
    };

    int maxFatigue = 0;
    int intensityBonus = 0;

    fatigueKeywords.forEach((keyword, score) {
      if (text.contains(keyword)) {
        if (score > maxFatigue) maxFatigue = score;
      }
    });

    intensifiers.forEach((keyword, score) {
      if (text.contains(keyword)) intensityBonus += score;
    });

    if (maxFatigue == 0) maxFatigue = 25;

    int finalFatigue = maxFatigue + intensityBonus;
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

  Widget _buildStatsCardBody() {
    if (_todos.isEmpty) {
      return const Center(child: Text("AI가 할 일의 피로도 기반으로 통계를 제공합니다."));
    }
    final completed = _todos.where((t) => t.isDone).toList();
    double completedFatigue = _todos
    .where((todo) => todo.isDone)        // 완료된 할 일만 필터링
    .fold(0, (sum, todo) => sum + todo.fatigue); // 피로도 합산
    double totalFatigue = _todos.fold(0, (sum, item) => sum + item.fatigue);
    final bool allDone = _todos.every((todo) => todo.isDone);
    String feedbackMessage;
    Color completedFatigueColor;
    
    if (completedFatigue >= 90) {
      completedFatigueColor = Colors.redAccent;
    } else if (totalFatigue >= 60) {
      completedFatigueColor = Colors.orangeAccent;
    } else if (totalFatigue >= 30) {
      completedFatigueColor = Colors.lightGreen;
    } else {
      completedFatigueColor = Colors.lightBlue;
    }

    if (completed.isEmpty) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "아직 완료한 일이 없습니다.",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: LinearProgressIndicator(
              value: 0,
              minHeight: 12,
              backgroundColor: Colors.grey[300],
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.greenAccent),
            ),
          ),
        ],
      );
    }

    if (allDone) {
      if (totalFatigue > 75) {
        feedbackMessage = "오늘은 정말 고된 하루였네요! 대단하십니다. 충분한 휴식으로 꼭 재충전하세요. 🔋";
      } else if (totalFatigue > 40) {
        feedbackMessage = "알찬 하루를 보내셨군요! 오늘의 노력 덕분에 내일은 더 가벼울 거예요. 멋져요! ✨";
      } else if (totalFatigue > 20){
        feedbackMessage = "가벼운 일들을 모두 마치셨네요. 오늘 하루도 수고하셨습니다! 편안한 저녁 보내세요. 😊";
      } else {
        feedbackMessage = "가끔은 잠깐 쉬어가는 것도 중요하죠. 오늘은 편히 쉬고, 내일 다시 힘차게 가봐요. 🌿";
      }

      return Center(
        child: Text(
          feedbackMessage,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      );
    } else {
      final remainingTodos = _todos.where((todo) => !todo.isDone).toList();
      remainingTodos.sort((a, b) => b.fatigue.compareTo(a.fatigue));

      String suggestMessage;
      final completed = _todos.where((todo) => todo.isDone).toList();
      double completedFatigue = completed.fold(0, (sum, item) => sum + item.fatigue);

      if (completedFatigue > 100) {
        suggestMessage = "이제까지 진짜 열일하셨네요. 😮‍💨 슬슬 그만하고 푹 쉬는 건 어때요? 🌙✨";
      } else if (completedFatigue > 80) {
        suggestMessage = "지금까지 꽤 바빴던 거 같아요 😌 너무 무리하지 말고 잠깐 쉬어볼까요? ☕💤";
      } else {
      suggestMessage = "피로도 높은 순서";
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          Text(
          "오늘 완료한 작업 피로도: ${completedFatigue.toInt()}%",
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: LinearProgressIndicator(
              value: (completedFatigue / 100).clamp(0.0, 1.0),
              minHeight: 12,
              backgroundColor: Colors.grey.shade300,
              valueColor: AlwaysStoppedAnimation<Color>(completedFatigueColor),
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          const SizedBox(height: 10),
          const Divider(),
          const SizedBox(height: 10),
          Text(
            suggestMessage,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          
          ...remainingTodos.map(
            (todo) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: Text(
                "${todo.text} - ${todo.fatigue}%",
                style: const TextStyle(fontSize: 14),
              ),
            ),
          ),
        ],
      );
    }
  }

  Widget _buildFatigueProgressBar() {
    if (_todos.isEmpty) {
      return const Center(child: Text("할 일을 추가하면 피로도가 계산됩니다."));
    }
    double totalFatigue = _todos.fold(0, (sum, item) => sum + item.fatigue);

    

    /*if (completed.isEmpty) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "아직 완료한 일이 없습니다.",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: LinearProgressIndicator(
              value: 0,
              minHeight: 12,
              backgroundColor: Colors.grey[300],
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.greenAccent),
            ),
          ),
        ],
      );
    }*/
    //double fatigue = completed.fold(0, (sum, item) => sum + item.fatigue);
    
    Color fatigueColor;
    
    if (totalFatigue >= 90) {
      fatigueColor = Colors.redAccent;
    } else if (totalFatigue >= 60) {
      fatigueColor = Colors.orangeAccent;
    } else if (totalFatigue >= 30) {
      fatigueColor = Colors.lightGreen;
    } else {
      fatigueColor = Colors.lightBlue;
    }
    Color averageFatigueColor;
    
    if (totalFatigue/_todos.length >= 60) {
      averageFatigueColor = Colors.redAccent;
    } else if (totalFatigue/_todos.length >= 50) {
      averageFatigueColor = Colors.orangeAccent;
    } else if (totalFatigue/_todos.length >= 35) {
      averageFatigueColor = Colors.lightGreen;
    } else {
      averageFatigueColor = Colors.lightBlue;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "오늘 총 작업 피로도: ${totalFatigue.toInt()}%",
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 10),
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: LinearProgressIndicator(
            value: (totalFatigue / 100).clamp(0.0, 1.0),
            minHeight: 12,
            backgroundColor: Colors.grey.shade300,
            valueColor: AlwaysStoppedAnimation<Color>(fatigueColor),
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        SizedBox(height: 6,),
        Text(
          "오늘 작업 평균 피로도: ${((totalFatigue)/_todos.length).roundToDouble()}%",
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
        ),
          const SizedBox(height: 10),
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: LinearProgressIndicator(
            value: ((totalFatigue / _todos.length)/100).clamp(0.0, 1.0),
            minHeight: 12,
            backgroundColor: Colors.grey.shade300,
            valueColor: AlwaysStoppedAnimation<Color>(averageFatigueColor),
            borderRadius: BorderRadius.circular(5),
          ),
        ),
      ],
    );
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
              // ✅ const 제거
              _DashBoardCard(
                title: '오늘의 할일',
                icon: Icons.event_note_rounded,
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
                                        ? Colors.lightGreen
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
                                    fontWeight: FontWeight.w600
                                  ),
                                ),
                                subtitle: Text(
                                  '예상 피로도: ${todo.fatigue}%',
                                  style: TextStyle(
                                    color: todo.isDone
                                        ? Colors.grey
                                        : const Color.fromARGB(255, 91, 91, 91),
                                    fontSize: 12,
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
                title: '오늘의 피로도',
                icon: Icons.bolt,
                body: _buildFatigueProgressBar(),
              ),
              _DashBoardCard(
                title: '오늘의 통계',
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
      elevation: 2,
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
