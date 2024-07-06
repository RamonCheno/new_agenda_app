part of 'index_task.dart';

abstract class ITaskProvider {
  Future<List<Task>> getTaskAll();
  Future<String> insertTask(Task task);
  Future<Task?> getTask(String id);
  Future<String> updateTask(Task task);
  Future<void> deleteTask(Task task);
  Future<List<Task>> getTasksAllByDate(String date);
}
