import 'package:get/get.dart';
import 'package:new_agenda_app/app/data/providers/tasks/index_task.dart';
import 'package:new_agenda_app/app/data/repositories/tasks/index_repository.dart';

import '../controllers/update_task_controller.dart';

class UpdateTaskBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UpdateTaskController>(
      () => UpdateTaskController(
        TaskRepository(
          TaskProvider(),
        ),
      ),
    );
  }
}
