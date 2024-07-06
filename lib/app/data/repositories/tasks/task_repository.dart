part of 'index_repository.dart';

class TaskRepository extends ITasksRepository{

  final TaskProvider _taskProvider;
  TaskRepository(this._taskProvider);
  
  @override
  Future<void> deleteTask(TaskDto taskDto) {
    // TODO: implement deleteTask
    throw UnimplementedError();
  }
  
  @override
  Future<TaskDto?> getTask(String id) {
    // TODO: implement getTask
    throw UnimplementedError();
  }
  
  @override
  Future<List<TaskDto>> getTasksAll() {
    // TODO: implement getTasksAll
    throw UnimplementedError();
  }
  
  @override
  Future<List<TaskDto>> getTasksAllByDay(String daySelected) {
    // TODO: implement getTasksAllByDay
    throw UnimplementedError();
  }
  
  @override
  Future<String> insertTask(TaskDto taskDto) {
    // TODO: implement insertTask
    throw UnimplementedError();
  }
  
  @override
  Future<String> updateTask(TaskDto taskDto) {
    // TODO: implement updateTask
    throw UnimplementedError();
  }

}