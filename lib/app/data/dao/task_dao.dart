import 'package:floor/floor.dart';
import 'package:new_agenda_app/app/data/models/tasks_model.dart';

@dao
abstract class TaskDao {
  @Query('SELECT * FROM task')
  Future<List<Task>> getAllTasks();

  @Query('SELECT * FROM task where date = :date')
  Future<List<Task>> getAllTasksByDate(String date);

  @Query('SELECT * FROM task where id = :id')
  Future<Task?> getTaskById(String id);

  @insert
  Future<void> insertTask(Task task);

  @update
  Future<void> updateTaskById(Task task);

  @delete
  Future<void> deleteTaskById(Task task);
}
