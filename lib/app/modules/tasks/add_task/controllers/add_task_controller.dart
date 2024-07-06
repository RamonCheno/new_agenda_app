
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_agenda_app/app/core/util/index_util.dart';
import 'package:new_agenda_app/app/data/dto/task_dto.dart';
import 'package:new_agenda_app/app/data/repositories/tasks/index_repository.dart';
import 'package:new_agenda_app/app/modules/calendar/calendar.dart';
import 'package:new_agenda_app/app/modules/tasks/tasks.dart';


class AddTaskController extends GetxController {
  //TODO: Implement AddTaskController.

  AddTaskController(this._tasksRepo);

  final TaskRepository _tasksRepo;

  final newTaskController = TextEditingController();
  final TasksController _taskController = Get.find<TasksController>();
  final CalendarController _calendarController = Get.find<CalendarController>();
  DateTime _dayTask = DateTime.now();
  final Rx<String> _dayTaskFormat = "".obs;
  TimeOfDay _hourTask = TimeOfDay.now();
  final Rx<String> _hourTaskFormat = "".obs;

  String get dayTaskFormat => _dayTaskFormat.value;
  String get hourTaskFormat => _hourTaskFormat.value;

  // @override
  // void onInit() {
  //   super.onInit();
  // }

  // @override
  // void onReady() {
  //   super.onReady();
  // }

  @override
  void onClose() {
    // newTaskController.dispose();
    super.onClose();
  }

  void newTask(String taskName, {String? dateTask, String? hourTask}) async {
    // Stopwatch stopWatch = Stopwatch();
    //       stopWatch.start();
    try {
      if (dateTask != null && hourTask != null && taskName.isNotEmpty) {
        // debugPrint("Tarea: $taskName con fecha $dateTask y hora: $hourTask");
        final responseSync =
            await insertTask(taskName, dateTask: dateTask, hourTask: hourTask);
        ComponentsUtil.showSnackBar(
            'Tarea agregado', responseSync, Colors.green.shade900);
        _taskController.getAllTasks();
        _calendarController.getTaskAllByDay(dateTask);
        newTaskController.clear();
      } else {
        ComponentsUtil.showSnackBar(
          'Tarea Vacia',
          "No se puede agregar tareas vacias",
          Colors.red,
        );
      }
    } catch (e) {
      debugPrint(e.toString());
    }

    // stopWatch.stop();
    // Duration time = stopWatch.elapsed;
    // debugPrint('Tiempo Transcurrido $time');
    // stopWatch.reset();

  }

  Future<String> insertTask(String taskName,
      {required String dateTask, required String hourTask}) async {
    final int timeStamp = _createUniqueId();
    debugPrint("$timeStamp");
    final taskDto = TaskDto(
        nameTask: taskName, dateTask: dateTask, hourTask: hourTask, timeStamp: timeStamp);
    final response = _tasksRepo.insertTask(taskDto);
    final responseSync = await response;

    await NotificationUtil.showLocalNotification(
        hourTask, dateTask, taskName, timeStamp);
    return responseSync;
  }

  void selectDate(BuildContext context) async {
    FocusScope.of(context).requestFocus(FocusNode());
    final Future<DateTime?> pickedDay = showDatePicker(
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      context: context,
      initialDate: _dayTask,
      firstDate: DateTime(2024),
      lastDate: DateTime(2099),
      currentDate: _dayTask,
    );
    DateTime? pickedDay2 = await pickedDay;
    if (pickedDay2 != null) {
      _dayTask = pickedDay2;
      _dayTaskFormat.value = ConvertTypesUtil.convertDateToString(_dayTask);
      // update();
    }
  }

  void selectTime(BuildContext context) async {
    FocusScope.of(context).requestFocus(FocusNode());
    final Future<TimeOfDay?> pickedTime = showTimePicker(
      initialEntryMode: TimePickerEntryMode.dialOnly,
      context: context,
      initialTime: _hourTask,
    );
    TimeOfDay? pickedTime2 = await pickedTime;
    if (pickedTime2 != null) {
      _hourTask = pickedTime2;
      _hourTaskFormat.value = ConvertTypesUtil.convertHourToString(_hourTask);
      debugPrint(_hourTaskFormat.value);
    }
  }

  int _createUniqueId() {
    int id = DateTime.now().millisecondsSinceEpoch.remainder(100000);
    debugPrint("$id");
    return id;
  }
}
