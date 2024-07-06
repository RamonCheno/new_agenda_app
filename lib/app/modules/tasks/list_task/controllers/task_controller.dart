import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_agenda_app/app/core/util/index_util.dart';
import 'package:new_agenda_app/app/data/dto/task_dto.dart';
import 'package:new_agenda_app/app/data/repositories/tasks/index_repository.dart';

class TasksController extends GetxController {
  TasksController(this._tasksRepo);

  //MARK: VARIABLES
  final TaskRepository _tasksRepo;
  final _title = 'Agenda';
  final List<TaskDto> _listTaskDto = <TaskDto>[].obs;

  //MARK: GETTERS
  String get title => _title;
  List<TaskDto> get listTaskDto => _listTaskDto;

  @override
  void onInit() {
    super.onInit();
    getAllTasks();
  }

  ///Obtiene todas las tareas y las agrega a la lista de tareas
  ///si la tarea no existe en la lista.
  void getAllTasks() async {
    // Stopwatch stopWatch = Stopwatch();
    // stopWatch.start();
    try {
      List<TaskDto> listTask = await _tasksRepo.getTasksAll();
      if (listTask.isNotEmpty) {
        _listTaskDto.clear();
        final uniqueTasks = listTask.where(
          (task) => !_listTaskDto.any((t) => t.id == task.id),
        );
        _listTaskDto.addAll(uniqueTasks);
      }
    } catch (e) {
      ComponentsUtil.showSnackBar("Error", e.toString(), Colors.red);
    }
  }

  Future<TaskDto?> getTaskById(String uuid) async {
    // Busca la tarea por su uuid en la base de datos
    final TaskDto? taskDtoSelect = await _tasksRepo.getTask(uuid);

    // Si la tarea existe en la base de datos se devuelve la tarea
    if (taskDtoSelect != null) {
      return taskDtoSelect;
    }
    // Si no existe en la base de datos se devuelve null
    else {
      return null;
    }
  }

  Future<void> _updateTask(TaskDto task) async {
    try {
      await _tasksRepo.updateTask(task);
    } catch (e) {
      ComponentsUtil.showSnackBar("Error", e.toString(), Colors.red);
    }
  }

  //Actualizar el estado de la tarea
  void updateTaskDone(String uuidIask, bool newDone) async {
    // Stopwatch stopWatch = Stopwatch();
    // stopWatch.start();
    final task = await getTaskById(uuidIask);
    if (task != null) {
      // final task = _listTaskDto[taskIndex];
      task.isDoneObs = newDone;
      await _updateTask(task);
      _updateListTaskDto(task);
      debugPrint("Estado de tarea actualizada");
      // getAllTasks();
    }
    // stopWatch.stop();
    // Duration time = stopWatch.elapsed;
    // debugPrint('Tiempo Transcurrido: $time');
    // stopWatch.reset();
  }

  void _updateListTaskDto(TaskDto task) {
    final index = _listTaskDto.indexWhere((item) => item.id == task.id);
    if (index != -1) {
      _listTaskDto[index] = task;
    }
  }

  Future<void> _deleteTask(TaskDto task) async {
    try {
      await _tasksRepo.deleteTask(task);
    } catch (e) {
      ComponentsUtil.showSnackBar("Error", e.toString(), Colors.red);
    }
  }

  void confirmDeleteTask(String uuid) {
    ComponentsUtil.showDeleteDialog(() {
      deleteTaskSelected(uuid);
    });
  }

  void deleteTaskSelected(String uuid) async {
    try {
      final task = await getTaskById(uuid);
      if (task != null) {
        int timeStamp = task.timeStamp!;
        await NotificationUtil.cancelNotification(timeStamp);
        await _deleteTask(task);
        _listTaskDto.removeWhere((item) => item.id == uuid);
      }
      ComponentsUtil.showSnackBar('Cita eliminado',
          "Se elimino cita correctamente", Colors.green.shade900);
    } catch (e) {
      ComponentsUtil.showSnackBar("Error", e.toString(), Colors.red);
    }
  }
  
}
