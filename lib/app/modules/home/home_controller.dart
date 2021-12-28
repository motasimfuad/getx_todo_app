import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_todo_app/app/data/models/task.dart';
import 'package:getx_todo_app/app/data/services/storage/repository.dart';

class HomeController extends GetxController {
  TaskRepository taskRepository;
  HomeController({
    required this.taskRepository,
  });
  final formKey = GlobalKey<FormState>();
  final TextEditingController editController = TextEditingController();
  final chipIndex = 0.obs;
  final tasks = <Task>[].obs;
  final deleting = false.obs;
  final task = Rx<Task?>(null);
  final doingTodos = <dynamic>[].obs;
  final doneTodos = <dynamic>[].obs;

  @override
  void onInit() {
    super.onInit();
    tasks.assignAll(taskRepository.readTasks());
    ever(tasks, (_) => taskRepository.writeTasks(tasks));
  }

  @override
  void onClose() {
    super.onClose();
    editController.dispose();
  }

  void changeChipIndex(value) {
    chipIndex.value = value;
  }

  bool addTask(Task task) {
    if (tasks.contains(task)) {
      return false;
    } else {
      tasks.add(task);
      return true;
    }
  }

  void deleteTask(Task task) {
    tasks.remove(task);
  }

  void changeDeleting(bool value) {
    deleting.value = value;
  }

  void changeTask(Task? select) {
    task.value = select;
  }

  int totalTodos() {
    return doingTodos.length + doneTodos.length;
  }

  void changeTodos(List<dynamic> select) {
    doingTodos.clear();
    doneTodos.clear();
    for (var item in select) {
      if (item['done'] == true) {
        doneTodos.add(item);
      } else {
        doingTodos.add(item);
      }
    }
  }

  updateTask(Task task, String title) {
    var todos = task.todos ?? [];
    if (containTodo(todos, title)) {
      return false;
    } else {
      var todo = {'title': title, 'done': false};
      todos.add(todo);
      var newTask = task.copyWith(todos: todos);
      var oldIdx = tasks.indexOf(task);
      tasks[oldIdx] = newTask;
      tasks.refresh();
      return true;
    }
  }

  bool containTodo(List todos, String title) {
    return todos.any((element) => element['title'] == title);
  }
}
