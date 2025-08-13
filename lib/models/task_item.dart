class TaskItem {
  final String id;
  final String title;
  final double fatiue;
  bool done;
  TaskItem({
    required this.id,
    required this.title,
    required this.fatiue,
    this.done = false,
  });
}
