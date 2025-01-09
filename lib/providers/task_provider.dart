import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:task_manager/models/task.dart';

class TaskProvider extends ChangeNotifier {
  late Box<Task> _taskBox;
  List<Task> _tasks = [];

  List<Task> get tasks => _tasks;

  TaskProvider() {
    _taskBox = Hive.box<Task>('tasks');
    _loadTasks();
  }

  void _loadTasks() {
    _tasks = _taskBox.values.toList();
    notifyListeners();
  }

  Future<void> addTask(Task task) async {
    await _taskBox.add(task);
    _loadTasks();
  }

  Future<void> updateTask(Task task) async {
    await task.save();
    _loadTasks();
  }

  Future<void> deleteTask(Task task) async {
    await task.delete();
    _loadTasks();
  }

  Future<void> deleteTasks(List<Task> tasks) async {
    for (var task in tasks) {
      await task.delete();
    }
    _loadTasks();
  }

  Future<void> toggleTaskStatus(Task task) async {
    task.isCompleted = !task.isCompleted;
    await task.save();
    _loadTasks();
  }
}