class TaskModel {
  final String id;
  final String title;
  final String note;
  final String startTime;
  final String endTime;
  final String data;
  final bool isCompleted;
  final int color;

  TaskModel({
    required this.id,
    required this.title,
    required this.note,
    required this.startTime,
    required this.endTime,
    required this.data,
    required this.isCompleted,
    required this.color,
  });
}
