import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_agenda_app/app/core/util/index_util.dart';
import 'package:new_agenda_app/app/data/dto/task_dto.dart';
import 'package:new_agenda_app/app/data/repositories/tasks/index_repository.dart';
import 'package:new_agenda_app/app/modules/calendar/calendar.dart';
import 'package:new_agenda_app/app/modules/tasks/tasks.dart';

class UpdateTaskController extends GetxController {
  //TODO: Implement UpdateTaskController.

  UpdateTaskController(this._tasksRepo);

  final TaskRepository _tasksRepo;
  final updateTaskController = TextEditingController();
  final TasksController _taskController = Get.find<TasksController>();
  final CalendarController _calendarController = Get.find<CalendarController>();
  DateTime _dayTask = DateTime.now();
  final Rx<String> _dayTaskFormat = "".obs;
  TimeOfDay _hourTask = TimeOfDay.now();
  final Rx<String> _hourTaskFormat = "".obs;
  Map<String, dynamic> taskSelect = {};

  String get dayTaskFormat => _dayTaskFormat.value;
  String get hourTaskFormat => _hourTaskFormat.value;

  @override
  void onInit() {
    //Cargar todo los datos de la tarea seleccionada antes de iniciar pantalla
    loadDataTask();
    super.onInit();
  }

  // @override
  // void onReady() {
  //   super.onReady();
  // }

  // @override
  // void onClose() {
  //   super.onClose();
  // }

  void loadDataTask() {
    if (Get.arguments != null) {
      taskSelect = Get.arguments as Map<String, dynamic>;
      debugPrint("Tarea seleccionada: ${taskSelect['id']}");
      debugPrint("Tarea seleccionada: ${taskSelect['name']}");
      debugPrint("Tarea selecionada: ${taskSelect['done']}");
      updateTaskController.text = taskSelect['name'];
      _dayTaskFormat.value = taskSelect['date'];
      _hourTaskFormat.value = taskSelect['hour'];
      _dayTask = ConvertTypesUtil.convertStringToDate(_dayTaskFormat.value);
      _hourTask = ConvertTypesUtil.convertStringToHour(_hourTaskFormat.value);
    }
  }

  void selectTime(BuildContext context) async {
    FocusScope.of(context).requestFocus(FocusNode());
    final Future<TimeOfDay?> pickedTime = showTimePicker(
      initialEntryMode: TimePickerEntryMode.dialOnly,
      context: context,
      initialTime: _hourTask,
    ); //Crear clase para la seleccion de hora y fecha
    TimeOfDay? pickedTime2 = await pickedTime;
    if (pickedTime2 != null) {
      _hourTask = pickedTime2;
      _hourTaskFormat.value = ConvertTypesUtil.convertHourToString(_hourTask);
      debugPrint(_hourTaskFormat.value);
    }
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
    ); //Crear clase para la seleccion de hora y fecha
    DateTime? pickedDay2 = await pickedDay;
    if (pickedDay2 != null) {
      _dayTask = pickedDay2;
      _dayTaskFormat.value = ConvertTypesUtil.convertDateToString(_dayTask);
      // update();
    }
  }

  //Actualizar el estado de la tarea
  void editTask(String taskName, {String? dateTask, String? hourTask}) async {
    // Stopwatch stopWatch = Stopwatch();
    //       stopWatch.start();
    try {
      if (dateTask != null && hourTask != null && taskName.isNotEmpty) {
        // debugPrint("Tarea: $taskName con fecha $dateTask y hora: $hourTask");
        final responseSync =
            await _updateTask(taskName, dateTask: dateTask, hourTask: hourTask);
        ComponentsUtil.showSnackBar(
            'Cita Editada', responseSync, Colors.green.shade900);
        _taskController.getAllTasks();
        _calendarController.getTaskAllByDay(dateTask);
        updateTaskController.clear();
      } else {
        ComponentsUtil.showSnackBar(
          'Cita Vacia',
          "No se puede agregar cita vacias",
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

  //Actualizar el estado de la tarea
  Future<String> _updateTask(String taskName,
      {required String dateTask, required String hourTask}) async {
    int timeStamp = taskSelect['timeStamp'];
    String uuid = taskSelect['id'];
    bool done = taskSelect['done'];
    debugPrint("$timeStamp");
    final taskDto = TaskDto(
      id: uuid,
      nameTask: taskName,
      dateTask: dateTask,
      hourTask: hourTask,
      timeStamp: timeStamp,
      isDone: done,
    );
    final response = _tasksRepo.updateTask(taskDto);
    final responseSync = await response;
    await NotificationUtil.cancelNotification(timeStamp);
    await NotificationUtil.showLocalNotification(
        hourTask, dateTask, taskName, timeStamp);
    return responseSync;
  }
}
