part of 'index_task.dart';

class TaskProvider extends ITaskProvider {
  final DatabaseHelper _databaseHelper = Get.find<DatabaseHelper>();

  TaskDao get taskDao => _databaseHelper.taskDao;

  @override
  Future<void> deleteTask(Task task) async {
    await taskDao.deleteTaskById(task);
  }

  @override
  Future<Task?> getTask(String id) async {
    // TODO: implement getTask
    Task? getTask = await taskDao.getTaskById(id);
    if (getTask != null) {
      // debugPrint("${getTask.id} ${getTask.name}, ${getTask.done}");
      return getTask;
    } else {
      return null;
    }
  }

  @override
  Future<List<Task>> getTaskAll() async {
    // TODO: implement getTaskAll
    List<Task> listTasks = await taskDao.getAllTasks();
    debugPrint("Todas las tareas");
    for (var task in listTasks) {
      debugPrint("""
        ${task.id} ${task.name}, ${task.done},
        ${task.date}, ${task.hour}, ${task.timeStamp}
      """);
    }
    return listTasks;
  }

  @override
  Future<List<Task>> getTasksAllByDate(String date) async {
    // TODO: implement getTasksAllByDate
    List<Task> listTasksByDay = await taskDao.getAllTasksByDate(date);
    debugPrint("Todas las tareas por fecha");
    for (var task in listTasksByDay) {
      debugPrint("""
        ${task.id} ${task.name}, ${task.done},
        ${task.date}, ${task.hour}, ${task.timeStamp}
      """);
    }
    return listTasksByDay;
  }

  @override
  Future<String> insertTask(Task task) async {
    // TODO: implement insertTask
    try {
      await taskDao.insertTask(task);
      debugPrint("Tarea registrada con Uuid: ${task.id}");
      return "Cita registrada";
    } catch (e) {
      return e.toString();
    }
  }

  @override
  Future<String> updateTask(Task task) async {
    // TODO: implement updateTask
    try {
      await taskDao.updateTaskById(task);
      return "Cita actualizada";
    } catch (e) {
      return e.toString();
    }
  }
}
