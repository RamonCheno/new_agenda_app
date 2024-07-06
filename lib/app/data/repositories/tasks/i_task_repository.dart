part of 'index_repository.dart';

abstract class ITasksRepository{

  Future<List<TaskDto>> getTasksAll();
  Future<List<TaskDto>> getTasksAllByDay(String daySelected);
  Future<String> insertTask(TaskDto taskDto);
  Future<TaskDto?> getTask(String id);
  Future<String> updateTask(TaskDto taskDto);
  Future<void> deleteTask(TaskDto taskDto);

}