import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasktune/data/app_state.dart'; // AppState: ChangeNotifier, todos: List<Todo>, toggleAt/removeAt 제공

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  void _toggleTodoStatus(BuildContext context, int index) {
    context.read<AppState>().toggleAt(index);
  }

  Widget _buildStatsCardBody(List<Todo> todos) {
    if (todos.isEmpty) {
      return const Center(child: Text("AI가 할 일의 피로도 기반으로 통계를 제공합니다."));
    }

    final completed = todos.where((t) => t.isDone).toList();
    final completedMet = completed.fold<double>(0, (sum, t) => sum + t.fatigue);
    final totalMet = todos.fold<double>(0, (sum, t) => sum + t.fatigue);
    final allDone = todos.every((t) => t.isDone);

    Color completedColor;
    if (completedMet >= 90) {
      completedColor = Colors.redAccent;
    } else if (completedMet >= 60) {
      completedColor = Colors.orangeAccent;
    } else if (completedMet >= 30) {
      completedColor = Colors.lightGreen;
    } else {
      completedColor = Colors.lightBlue;
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
              valueColor: const AlwaysStoppedAnimation<Color>(
                Colors.greenAccent,
              ),
            ),
          ),
        ],
      );
    }

    if (allDone) {
      final msg = totalMet > 75
          ? "오늘은 정말 고된 하루였네요! 대단하십니다. 충분한 휴식으로 꼭 재충전하세요. 🔋"
          : totalMet > 40
          ? "알찬 하루를 보내셨군요! 오늘의 노력 덕분에 내일은 더 가벼울 거예요. 멋져요! ✨"
          : totalMet > 20
          ? "가벼운 일들을 모두 마치셨네요. 오늘 하루도 수고하셨습니다! 편안한 저녁 보내세요. 😊"
          : "가끔은 잠깐 쉬어가는 것도 중요하죠. 오늘은 편히 쉬고, 내일 다시 힘차게 가봐요. 🌿";
      return Center(
        child: Text(
          msg,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      );
    }

    final remainingTodos = todos.where((t) => !t.isDone).toList()
      ..sort((a, b) => b.fatigue.compareTo(a.fatigue));

    final suggestMessage = completedMet > 100
        ? "이제까지 진짜 열일하셨네요. 😮‍💨 슬슬 그만하고 푹 쉬는 건 어때요? 🌙✨"
        : completedMet > 80
        ? "지금까지 꽤 바빴던 거 같아요 😌 너무 무리하지 말고 잠깐 쉬어볼까요? ☕💤"
        : "피로도 높은 순서";

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        Text(
          "오늘 완료한 작업 피로도: ${completedMet.toInt()}",
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: LinearProgressIndicator(
            value: (completedMet / 100).clamp(0.0, 1.0),
            minHeight: 12,
            backgroundColor: Colors.grey.shade300,
            valueColor: AlwaysStoppedAnimation<Color>(completedColor),
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
          (t) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: Text("${t.title} - ${t.fatigue.toStringAsFixed(0)}"),
          ),
        ),
      ],
    );
  }

  Widget _buildFatigueProgressBar(List<Todo> todos) {
    if (todos.isEmpty) {
      return const Center(child: Text("할 일을 추가하면 피로도가 계산됩니다."));
    }

    final totalMet = todos.fold<double>(0, (sum, t) => sum + t.fatigue);
    final avg = totalMet / todos.length;

    Color totalColor;
    if (totalMet >= 90) {
      totalColor = Colors.redAccent;
    } else if (totalMet >= 60) {
      totalColor = Colors.orangeAccent;
    } else if (totalMet >= 30) {
      totalColor = Colors.lightGreen;
    } else {
      totalColor = Colors.lightBlue;
    }

    Color avgColor;
    if (avg >= 60) {
      avgColor = Colors.redAccent;
    } else if (avg >= 50) {
      avgColor = Colors.orangeAccent;
    } else if (avg >= 35) {
      avgColor = Colors.lightGreen;
    } else {
      avgColor = Colors.lightBlue;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "오늘 총 작업 피로도: ${totalMet.toInt()}",
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 10),
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: LinearProgressIndicator(
            value: (totalMet / 100).clamp(0.0, 1.0),
            minHeight: 12,
            backgroundColor: Colors.grey.shade300,
            valueColor: AlwaysStoppedAnimation<Color>(totalColor),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          "오늘 작업 평균 피로도: ${avg.toStringAsFixed(0)}",
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 10),
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: LinearProgressIndicator(
            value: (avg / 100).clamp(0.0, 1.0),
            minHeight: 12,
            backgroundColor: Colors.grey.shade300,
            valueColor: AlwaysStoppedAnimation<Color>(avgColor),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final app = context.watch<AppState>();
    final todos = app.todos;

    return SingleChildScrollView(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _DashBoardCard(
                title: '오늘의 할일',
                icon: Icons.event_note_rounded,
                body: Column(
                  children: [
                    const SizedBox(height: 10),
                    todos.isEmpty
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
                            itemCount: todos.length,
                            itemBuilder: (context, index) {
                              final t = todos[index];
                              return ListTile(
                                leading: IconButton(
                                  icon: Icon(
                                    t.isDone
                                        ? Icons.check_circle
                                        : Icons.check_circle_outline,
                                    color: t.isDone
                                        ? Colors.lightGreen
                                        : Colors.grey,
                                  ),
                                  onPressed: () =>
                                      _toggleTodoStatus(context, index),
                                ),
                                title: Text(
                                  t.title,
                                  style: TextStyle(
                                    decoration: t.isDone
                                        ? TextDecoration.lineThrough
                                        : TextDecoration.none,
                                    color: t.isDone
                                        ? Colors.grey
                                        : Colors.black87,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                subtitle: Text(
                                  '피로도: ${t.fatigue.toStringAsFixed(0)}',
                                  style: TextStyle(
                                    color: t.isDone
                                        ? Colors.grey
                                        : const Color.fromARGB(255, 91, 91, 91),
                                    fontSize: 12,
                                  ),
                                ),
                                trailing: IconButton(
                                  icon: const Icon(Icons.delete_outline),
                                  onPressed: () =>
                                      context.read<AppState>().removeAt(index),
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
                body: _buildFatigueProgressBar(todos),
              ),
              _DashBoardCard(
                title: '오늘의 통계',
                icon: Icons.bar_chart_rounded,
                body: _buildStatsCardBody(todos),
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
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
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
