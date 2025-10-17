import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _DashBoardCard(
                title: '오늘의 할일',
                icon: Icons.calendar_today_rounded,
                body: Text('body'),
              ),
              _DashBoardCard(
                title: '미니 통계',
                icon: Icons.bar_chart_rounded,
                body: Text('body'),
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
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // --- 제목 ---
            Row(
              children: [
                Icon(icon),
                const SizedBox(
                  width: 10,
                ),
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
