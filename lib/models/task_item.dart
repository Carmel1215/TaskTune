class TaskItem {
  final String id;
  final String title;
  // final String category;
  // final int priority; // 1: 높음, 2: 보통, 3: 낮음
  // final double fatigueScore; // AI 계산 값
  // final DateTime createdAt;
  // final DateTime? dueDate;
  bool done;

  TaskItem({
    required this.id,
    required this.title,
    // required this.category,
    // required this.priority,
    // required this.fatigueScore,
    // required this.createdAt,
    // this.dueDate,
    this.done = false,
  });
}
