import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'package:new_agenda_app/app/data/models/tasks_model.dart';
import 'package:new_agenda_app/app/data/dao/task_dao.dart';

part 'database.g.dart';

@Database(version: 1, entities: [Task])
abstract class DatabaseHelper extends FloorDatabase {

  TaskDao get taskDao;

  static Future<DatabaseHelper> init() async {
    DatabaseHelper instance = await $FloorDatabaseHelper
        .databaseBuilder("agenda_database.db")
        .build();
    return instance;
  }
}
