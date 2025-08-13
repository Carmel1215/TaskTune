import 'package:flutter/material.dart';
import 'package:tasktune/widgets/app_scaffold.dart';

class StatsScreen extends StatelessWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      index: 0,
      appBar: AppBar(
        title: const Text('통계'),
      ),
      body: const SafeArea(
        child: Center(
          child: Text('통계 스크린'),
        ),
      ),
    );
  }
}
