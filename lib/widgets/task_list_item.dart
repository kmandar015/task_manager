import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/models/task.dart';
import 'package:task_manager/providers/task_provider.dart';

class TaskListItem extends StatelessWidget {
  final Task task;
  final bool isSelectionMode;
  final bool isSelected;
  final Function(Task) onSelect;
  final VoidCallback onTap;

  const TaskListItem({
    super.key,
    required this.task,
    this.isSelectionMode = false,
    this.isSelected = false,
    required this.onSelect,
    required this.onTap,
  });

  Color _getPriorityColor() {
    switch (task.priority) {
      case Priority.high:
        return Colors.red;
      case Priority.medium:
        return Colors.orange;
      case Priority.low:
        return Colors.green;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: InkWell(
        onTap: onTap,
        onLongPress: () {
          if (!isSelectionMode) {
            onSelect(task);
          }
        },
        child: Container(
          decoration: BoxDecoration(
            border: isSelected
                ? Border.all(
              color: Theme.of(context).colorScheme.primary,
              width: 2,
            )
                : null,
          ),
          child: ListTile(
            leading: isSelectionMode
                ? Checkbox(
              value: isSelected,
              onChanged: (_) => onSelect(task),
            )
                : Checkbox(
              value: task.isCompleted,
              onChanged: (bool? value) {
                context.read<TaskProvider>().toggleTaskStatus(task);
              },
            ),
            title: Text(
              task.title,
              style: TextStyle(
                decoration: task.isCompleted ? TextDecoration.lineThrough : null,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (task.description != null)
                  Text(
                    task.description!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                Text(
                  'Due: ${task.dueDate.toString().split(' ')[0]}',
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            ),
            trailing: Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: _getPriorityColor(),
                shape: BoxShape.circle,
              ),
            ),
          ),
        ),
      ),
    );
  }
}