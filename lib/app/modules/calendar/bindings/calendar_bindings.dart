import 'package:get/get.dart';
import 'package:new_agenda_app/app/data/providers/tasks/index_task.dart';
import 'package:new_agenda_app/app/data/repositories/tasks/index_repository.dart';

import '../controllers/calendar_controller.dart';

class CalendarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CalendarController>(
      () => CalendarController(
        TaskRepository(
          TaskProvider(),
        ),
      ),
    );
  }
}
