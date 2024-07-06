import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_agenda_app/app/core/util/component_util.dart';
import 'package:new_agenda_app/app/core/util/convert_types_util.dart';
import 'package:new_agenda_app/app/data/dto/task_dto.dart';
import 'package:new_agenda_app/app/data/repositories/tasks/index_repository.dart';

class CalendarController extends GetxController {
  //TODO: Implement CalendarController.

  final String _title = "Calendario";

  final TaskRepository _tasksRepo;

  String get title => _title;

  final List<TaskDto> _listTaskDtoByDate = <TaskDto>[].obs;

  DateTime _dayTask = DateTime.now();
  final Rx<String> _dayTaskFormat = "".obs;

  List<TaskDto> get listTaskDtoByDate => _listTaskDtoByDate;
  DateTime get dayTask => _dayTask;
  String get dayTaskFormat => _dayTaskFormat.value;

  CalendarController(this._tasksRepo);

  @override
  void onInit() {
    super.onInit();
    _dayTaskFormat.value = ConvertTypesUtil.convertDateToString(_dayTask);
    String dayActual = _dayTaskFormat.value;
    getTaskAllByDay(dayActual);
  }

  // @override
  // void onReady() {
  //   super.onReady();
  // }

  // @override
  // void onClose() {
  //   super.onClose();
  // }

  //Obtener la lista de las tareas por fecha y si la fecha seleccionada no tiene elemento
  //que vacie la lista _listTaskDtoByDate

  void getTaskAllByDay(String daySelected) async {
    //   Stopwatch stopWatch = Stopwatch();
    //   stopWatch.start();
    try {
      List<TaskDto> listTaskDay =
          await _tasksRepo.getTasksAllByDay(daySelected);

      if (listTaskDay.isNotEmpty) {
        _listTaskDtoByDate.clear();
        final uniqueTasks = listTaskDay.where(
          (task) => !_listTaskDtoByDate.any(
            (t) => t.dateTask == daySelected && t.id == task.id,
          ),
        );
        _listTaskDtoByDate.addAll(uniqueTasks);
      } else {
        _listTaskDtoByDate.clear();
      }
    } catch (e) {
      ComponentsUtil.showSnackBar("Error", e.toString(), Colors.red);
    }

    //   _tasksRepo.getTasksAllByDay(daySelected).then((tasks) {
    //     if (tasks.isNotEmpty) {
    //       _listTaskDtoByDate.clear();
    //       final uniqueTasks = tasks.where(
    //         (task) => !_listTaskDtoByDate.any(
    //           (t) => t.date == daySelected && t.id == task.id,
    //         ),
    //       );
    //       _listTaskDtoByDate.addAll(uniqueTasks);
    //     } else {
    //       _listTaskDtoByDate.clear();
    //     }
    //   }).catchError((e) {
    //     ComponentsUtil.showSnackBar("Error", e.toString(), Colors.red);
    //   });
    // stopWatch.stop();
    // Duration time = stopWatch.elapsed;
    // debugPrint('Tiempo Transcurrido: $time');
    // stopWatch.reset();
  }

  void onDateChanged(DateTime value) {
    _dayTask = value;
    _dayTaskFormat.value = ConvertTypesUtil.convertDateToString(_dayTask);
    String dayActual = _dayTaskFormat.value;
    getTaskAllByDay(dayActual);
    // update();
    // debugPrint(
    //     "Fecha: $dayActual /n Numero de tareas: ${_listTaskDtoByDate.length}");
  }
}
