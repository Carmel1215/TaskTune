import 'package:tasktune/models/task_item.dart';

class TodayTaskService {
  Future<List<TaskItem>> fetchToday() async {
    await Future.delayed(const Duration(milliseconds: 400));
    return [
      TaskItem(id: '1', title: '수학 숙제 풀기', fatiue: 0.1),
      TaskItem(id: '2', title: '국어 숙제 풀기', fatiue: 0.23),
    ];
  }
}
