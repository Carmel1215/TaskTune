import 'package:flutter/material.dart';

class AppScaffold extends StatelessWidget {
  final int index;
  final PreferredSizeWidget? appBar;
  final Widget body;
  const AppScaffold({
    super.key,
    required this.index,
    this.appBar,
    required this.body,
  });

  void _onTap(BuildContext context, int i) {
    if (i == index) return;
    switch (i) {
      case 0:
        Navigator.pushReplacementNamed(context, '/stats');
        break;
      case 1:
        Navigator.pushReplacementNamed(context, '/');
        break;
      case 2:
        Navigator.pushReplacementNamed(context, '/taskreview');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: body,
      bottomNavigationBar: NavigationBar(
        selectedIndex: index,
        onDestinationSelected: (i) => _onTap(context, i),
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
