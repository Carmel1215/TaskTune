import 'package:flutter/material.dart';
import 'package:tasktune/screens/home_screen.dart';
import 'package:tasktune/screens/stats_screen.dart';
import 'package:tasktune/screens/task_review_screen.dart';

class AppScaffold extends StatefulWidget {
  const AppScaffold({super.key});

  @override
  State<AppScaffold> createState() => _AppScaffoldState();
}

class _AppScaffoldState extends State<AppScaffold> {
  final _controller = PageController(initialPage: 1, keepPage: true);
  int _index = 1;

  final _pages = const [
    StatsScreen(key: PageStorageKey('stats')),
    HomeScreen(key: PageStorageKey('home')),
    TaskReviewScreen(key: PageStorageKey('taskreview')),
  ];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTap(int i) {
    if (i == _index) return;
    setState(() => _index = i);
    _controller.animateToPage(
      i,
      duration: const Duration(milliseconds: 280),
      curve: Curves.easeOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('할 일 추가 버튼 클릭')),
          );
        },
        shape: const CircleBorder(),
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text('Task Tune'),
      ),
      body: PageView(
        controller: _controller,
        onPageChanged: (i) => setState(() => _index = i),
        //physics: const NeverScrollableScrollPhysics(), // 손으로 스와이핑 막는 코드
        children: _pages,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: _onTap,
        destinations: [
          const NavigationDestination(
            icon: Icon(Icons.bar_chart_outlined),
            selectedIcon: Icon(Icons.bar_chart_rounded),
            label: '통계',
          ),
          const NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home_rounded),
            label: '홈',
          ),
          const NavigationDestination(
            icon: Icon(Icons.edit_note_outlined),
            selectedIcon: Icon(Icons.edit_note_rounded),
            label: '할 일 분석',
          ),
        ],
      ),
    );
  }
}
