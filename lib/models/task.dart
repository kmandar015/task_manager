import 'package:hive/hive.dart';

part 'task.g.dart';

@HiveType(typeId: 0)
enum Priority {
  @HiveField(0)
  high,
  @HiveField(1)
  medium,
  @HiveField(2)
  low
}

@HiveType(typeId: 1)
class Task extends HiveObject {
  @HiveField(0)
  String title;

  @HiveField(1)
  String? description;

  @HiveField(2)
  DateTime dueDate;

  @HiveField(3)
  Priority priority;

  @HiveField(4)
  bool isCompleted;

  Task({
    required this.title,
    this.description,
    required this.dueDate,
    required this.priority,
    this.isCompleted = false,
  });
}