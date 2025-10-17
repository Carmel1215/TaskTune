import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class StatsPage extends StatelessWidget {
  const StatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 511,
                    height: 500,
                    child: StatsCard(
                      title: '완료한 작업',
                      icon: Icons.checklist,
                      body: SizedBox(
                        width: double.infinity,
                        height: 420,
                        child: WeeklyBarChart(),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 7,
                  ),
                  SizedBox(
                    width: 511,
                    height: 500,
                    child: StatsCard(
                      title: '피로도',
                      icon: Icons.hardware,
                      body: SizedBox(
                        width: double.infinity,
                        height: 420,
                        child: FatiguePieChart(),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              StatsCard(
                title: '작업 별 피로도 순위',
                icon: Icons.filter_alt,
                body: TopFatigueTasksTable(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class StatsCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget body;

  const StatsCard({
    super.key,
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
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Icon(icon),
                const SizedBox(width: 10),
                Text(title),
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

class WeeklyBarChart extends StatelessWidget {
  const WeeklyBarChart({super.key});

  @override
  Widget build(BuildContext context) {
    final days = ['월', '화', '수', '목', '금', '토', '일'];
    final data = [3, 5, 2, 6, 4, 7, 5];
    final maxValue = data.reduce((a, b) => a > b ? a : b).toDouble();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(days.length, (i) {
        final ratio = (data[i] / maxValue).clamp(0.0, 1.0);
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: Row(
            children: [
              SizedBox(
                width: 28,
                child: Text(days[i], style: const TextStyle(fontSize: 16)),
              ),
              const SizedBox(width: 8),
              // ✅ 가로 막대 (폭은 비율 기반)
              Expanded(
                child: Stack(
                  children: [
                    Container(
                      height: 20,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    FractionallySizedBox(
                      widthFactor: ratio,
                      child: Container(
                        height: 20,
                        decoration: BoxDecoration(
                          color: Colors.lightBlue,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              SizedBox(
                width: 30,
                child: Text(
                  '${data[i]}',
                  textAlign: TextAlign.right,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}

class FatiguePieChart extends StatelessWidget {
  const FatiguePieChart({super.key});

  @override
  Widget build(BuildContext context) {
    final double usedFatigue = 70; // 하루 중 사용된 피로도 %
    final double remaining = 30; // 남은 여유 %

    return Stack(
      alignment: Alignment.center,
      children: [
        PieChart(
          PieChartData(
            centerSpaceRadius: 60,
            sectionsSpace: 2,
            startDegreeOffset: -90,
            sections: [
              PieChartSectionData(
                color: Colors.redAccent,
                value: usedFatigue,
                radius: 100,
                title: '',
              ),
              PieChartSectionData(
                color: Colors.grey.shade300,
                value: remaining,
                radius: 100,
                title: '',
              ),
            ],
          ),
        ),

        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '${usedFatigue.toInt()}%',
              style: const TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Colors.redAccent,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              '피로도',
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
          ],
        ),
      ],
    );
  }
}

class TopFatigueTasksTable extends StatelessWidget {
  const TopFatigueTasksTable({super.key});

  @override
  Widget build(BuildContext context) {
    final tasks = [
      {'name': '회의 준비', 'fatigue': 92},
      {'name': '리포트 작성', 'fatigue': 85},
      {'name': '코드 리뷰', 'fatigue': 78},
      {'name': '이메일 응답', 'fatigue': 71},
      {'name': '팀 미팅', 'fatigue': 67},
      {'name': '기타 업무', 'fatigue': 60},
    ]; // TODO 데이터 연결

    final topTasks = (List<Map<String, dynamic>>.from(
      tasks,
    )..sort((a, b) => b['fatigue'].compareTo(a['fatigue']))).take(5).toList();

    final maxFatigue = topTasks.first['fatigue'] as int;

    return Card(
      elevation: 10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DataTable(
              headingRowHeight: 36,
              dataRowMinHeight: 42,
              dataRowMaxHeight: 48,
              columnSpacing: 180,
              columns: const [
                DataColumn(label: Text('순위')),
                DataColumn(label: Text('작업명')),
                DataColumn(label: Text('피로도')),
                DataColumn(label: Text('비율')),
              ],
              rows: List.generate(topTasks.length, (i) {
                final task = topTasks[i];
                final fatigue = task['fatigue'] as int;
                final ratio = fatigue / maxFatigue;

                return DataRow(
                  cells: [
                    DataCell(Text('${i + 1}')),
                    DataCell(Text(task['name'])),
                    DataCell(Text('$fatigue')),
                    DataCell(
                      SizedBox(
                        width: 100,
                        height: 10,
                        child: Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            FractionallySizedBox(
                              widthFactor: ratio.clamp(0.0, 1.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: fatigue > 85
                                      ? Colors.redAccent
                                      : (fatigue > 70
                                            ? Colors.orangeAccent
                                            : Colors.lightBlue),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
