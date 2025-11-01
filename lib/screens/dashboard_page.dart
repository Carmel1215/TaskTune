import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasktune/data/app_state.dart'; // AppState

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  void _toggleTodoStatus(BuildContext context, int index) {
    context.read<AppState>().toggleAt(index);
  }

  // === 오늘의 통계 카드: 소모 kcal 총합 표시 ===
  Widget _buildStatsCardBody(List<Todo> todos, AppState app) {
    if (todos.isEmpty) {
      return const Center(
        child: Text(
          "Kcal 통계를 보려면 할 일을 추가해주세요.",
          style: TextStyle(color: Colors.grey),
        ),
      );
    }

    final totalKcal = app.totalKcalToday;
    final top = (todos.toList()..sort((a, b) => b.kcal.compareTo(a.kcal))).take(
      3,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        Text(
          "오늘 소모 칼로리 총합: ${totalKcal.toStringAsFixed(0)} kcal",
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 12),
        const Divider(),
        if (top.isNotEmpty) ...[
          const Text(
            "Top kcal 작업",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 6),
          ...top.map(
            (t) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Text("${t.title} · ${t.kcal.toStringAsFixed(0)} kcal"),
            ),
          ),
        ],
      ],
    );
  }

  // === 오늘의 피로도 카드: 총피로도 / 일일 용량(예: 1000) ===
  Widget _buildFatigueProgressCardBody(AppState app) {
    final totalFatigue = app.totalFatigueToday;
    final cap = app.dailyFatigueCapacity;
    final ratio = (cap > 0 ? (totalFatigue / cap) : 0.0).clamp(0.0, 1.0);

    Color barColor;
    if (ratio >= 0.9) {
      barColor = Colors.redAccent;
    } else if (ratio >= 0.6) {
      barColor = Colors.orangeAccent;
    } else if (ratio >= 0.3) {
      barColor = Colors.lightGreen;
    } else {
      barColor = Colors.lightBlue;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "오늘 총 작업 피로도: ${totalFatigue.toStringAsFixed(0)} / ${cap.toStringAsFixed(0)}",
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 10),
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: LinearProgressIndicator(
            value: ratio,
            minHeight: 12,
            backgroundColor: Colors.grey.shade300,
            valueColor: AlwaysStoppedAnimation<Color>(barColor),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          "진행률: ${(ratio * 100).toStringAsFixed(0)}%",
          style: const TextStyle(fontSize: 12, color: Colors.black54),
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
                                  '피로도: ${t.fatigue.toStringAsFixed(0)}\nKcal: ${t.kcal.toStringAsFixed(0)}',
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
                body: _buildFatigueProgressCardBody(app),
              ),
              _DashBoardCard(
                title: '오늘의 통계',
                icon: Icons.bar_chart_rounded,
                body: _buildStatsCardBody(todos, app),
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
