import 'package:get/get.dart';
import 'package:new_agenda_app/app/data/providers/tasks/index_task.dart';
import 'package:new_agenda_app/app/data/repositories/tasks/index_repository.dart';

import '../controllers/task_controller.dart';

class TasksBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TasksController>(
      () => TasksController(
        TaskRepository(
          TaskProvider(),
        ),
      ),
    );
  }
}