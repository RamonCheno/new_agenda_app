import 'package:get/get.dart';
import '../modules/tasks/tasks.dart';

class TasksRoutes {
  TasksRoutes._();

  static const addTask = '/tasks/add-task';
  static const updateTask = '/tasks/update-task';

  static final routes = [
    GetPage(
      name: addTask,
      page: () => const AddTaskPage(),
      binding: AddTaskBinding(),
    ),
    GetPage(
      name: updateTask,
      page: () => const UpdateTaskPage(),
      binding: UpdateTaskBinding(),
    ),
  ];
}