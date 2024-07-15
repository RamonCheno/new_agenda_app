part of 'index_repository.dart';

class TaskRepository extends ITasksRepository{

  final TaskProvider _taskProvider;
  TaskRepository(this._taskProvider);
  
  @override
  Future<void> deleteTask(TaskDto taskDto) async {
    // TODO: implement deleteTask
    Map<String, dynamic> taskDtoMap = taskDto.toMap();
    Task task = Task.fromMap(taskDtoMap);
    await _taskProvider.deleteTask(task);
  }

  @override
  Future<TaskDto?> getTask(String id) async {
    // TODO: implement getTask
    Task? task = await _taskProvider.getTask(id);
    if (task != null) {
      Map<String, dynamic> taskMap = task.toMap();
      TaskDto taskDto = TaskDto.fromMap(taskMap);
      return taskDto;
    } else {
      return null;
    }
  }

  @override
  Future<List<TaskDto>> getTasksAll() async {
    //TODO: implement getTasksAll
    List<Task> listTask = await _taskProvider.getTaskAll();
    List<Map<String, dynamic>> listTaskMap =
        listTask.map((item) => item.toMap()).toList();
    List<TaskDto> listTaskDto =
        listTaskMap.map((item) => TaskDto.fromMap(item)).toList();
    return listTaskDto;
  }

  @override
  Future<String> insertTask(TaskDto taskDto) async {
    // TODO: implement insertTask
    Map<String, dynamic> taskMap = taskDto.toMap();
    var uuid = const Uuid();
    Task task = Task(
      id: uuid.v4(),
      name: taskMap["name"],
      done: taskMap["done"],
      date: taskMap["date"],
      hour: taskMap["hour"],
      timeStamp: taskMap['timeStamp'],
    );
    String response = await _taskProvider.insertTask(task);
    return response;
  }

  @override
  Future<String> updateTask(TaskDto taskDto) async {
    // TODO: implement updateTask
    Map<String, dynamic> taskDtoMap = taskDto.toMap();
    Task task = Task.fromMap(taskDtoMap);
    String response = await _taskProvider.updateTask(task);
    return response;
  }

  @override
  Future<List<TaskDto>> getTasksAllByDay(String daySelected) async {
    List<Task> listTask = await _taskProvider.getTasksAllByDate(daySelected);
    // print("Fecha: $daySelected /n Numero de tareas: ${listTask.length}");
    List<Map<String, dynamic>> listTaskMap =
        listTask.map((item) => item.toMap()).toList();
    List<TaskDto> listTaskDto =
        listTaskMap.map((item) => TaskDto.fromMap(item)).toList();
    return listTaskDto;
  }
}