import 'package:get/get.dart';
import 'package:new_agenda_app/app/data/providers/tasks/index_task.dart';
import 'package:new_agenda_app/app/data/repositories/tasks/index_repository.dart';
import 'package:new_agenda_app/app/modules/tasks/tasks.dart';

class AddTaskBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddTaskController>(
      () => AddTaskController(
        TaskRepository(
          TaskProvider(),
        ),
      ),
    );
  }
}
