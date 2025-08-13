import 'package:flutter/material.dart';
import 'package:tasktune/widgets/app_scaffold.dart';

class TaskReviewScreen extends StatelessWidget {
  const TaskReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      index: 2,
      appBar: AppBar(
        title: const Text('할 일 리뷰'),
      ),
      body: const SafeArea(
        child: Center(
          child: Text('할 일 리뷰 스크린'),
        ),
      ),
    );
  }
}
