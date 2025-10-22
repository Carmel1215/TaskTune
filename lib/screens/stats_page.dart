import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class StatsPage extends StatelessWidget {
  const StatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 511,
                height: 500,
                child: StatsCard(
                  title: '완료한 작업',
                  icon: Icons.task_alt,
                  body: Text("대충 가로 막대그래프, 요일별로 보여주기"),
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
                  icon: Icons.battery_4_bar,
                  body: Text('오늘 계획된 작업 당 피로도/하루 최대 피로도 원그래프로 표현'),
                ),
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
