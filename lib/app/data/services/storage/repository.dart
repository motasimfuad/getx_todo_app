import 'package:getx_todo_app/app/data/models/task.dart';
import 'package:getx_todo_app/app/data/providers/task/provider.dart';

class TaskRepository {
  TaskProvider taskProvider;

  TaskRepository({
    required this.taskProvider,
  });

  List<Task> readTasks() {
    return taskProvider.readTasks();
  }

  void writeTasks(List<Task> tasks) {
    return taskProvider.writeTasks(tasks);
  }
}
