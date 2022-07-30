import 'package:hive/hive.dart';
import 'package:newtodo/model/task.dart';

class Todo {
  // ignore: unused_field
  late Box<Task> _task;
  Future<void> init() async {
    Hive.registerAdapter(TaskAdapter());
    _task = await Hive.openBox<Task>('task');
  }

  List<Task> getTasks(final String username) {
    final tasks = _task.values.where((element) => element.user == username);
    return tasks.toList();
  }

  void addTask(final String task, final String username) {
    _task.add(Task(user: username, task: task, completed: false));
  }

  void removeTask(final String task, final String username) async {
    final taskToRemove = _task.values.firstWhere(
      (element) => element.task == task && element.user == username,
    );
    await taskToRemove.delete();
  }

  Future<void> updateTask(
    final String task,
    final String username,
  ) async {
    final taskToEdit = _task.values.firstWhere(
      (element) => element.task == task && element.user == username,
    );
    final index = taskToEdit.key as int;
    await _task.put(
      index,
      Task(user: username, task: task, completed: !taskToEdit.completed),
    );
  }
}
