// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

abstract class $DatabaseHelperBuilderContract {
  /// Adds migrations to the builder.
  $DatabaseHelperBuilderContract addMigrations(List<Migration> migrations);

  /// Adds a database [Callback] to the builder.
  $DatabaseHelperBuilderContract addCallback(Callback callback);

  /// Creates the database and initializes it.
  Future<DatabaseHelper> build();
}

// ignore: avoid_classes_with_only_static_members
class $FloorDatabaseHelper {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $DatabaseHelperBuilderContract databaseBuilder(String name) =>
      _$DatabaseHelperBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $DatabaseHelperBuilderContract inMemoryDatabaseBuilder() =>
      _$DatabaseHelperBuilder(null);
}

class _$DatabaseHelperBuilder implements $DatabaseHelperBuilderContract {
  _$DatabaseHelperBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  @override
  $DatabaseHelperBuilderContract addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  @override
  $DatabaseHelperBuilderContract addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  @override
  Future<DatabaseHelper> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$DatabaseHelper();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$DatabaseHelper extends DatabaseHelper {
  _$DatabaseHelper([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  TaskDao? _taskDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Task` (`id` TEXT NOT NULL, `name` TEXT NOT NULL, `hour` TEXT NOT NULL, `date` TEXT NOT NULL, `done` INTEGER NOT NULL, `timeStamp` INTEGER NOT NULL, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  TaskDao get taskDao {
    return _taskDaoInstance ??= _$TaskDao(database, changeListener);
  }
}

class _$TaskDao extends TaskDao {
  _$TaskDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _taskInsertionAdapter = InsertionAdapter(
            database,
            'Task',
            (Task item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'hour': item.hour,
                  'date': item.date,
                  'done': item.done ? 1 : 0,
                  'timeStamp': item.timeStamp
                }),
        _taskUpdateAdapter = UpdateAdapter(
            database,
            'Task',
            ['id'],
            (Task item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'hour': item.hour,
                  'date': item.date,
                  'done': item.done ? 1 : 0,
                  'timeStamp': item.timeStamp
                }),
        _taskDeletionAdapter = DeletionAdapter(
            database,
            'Task',
            ['id'],
            (Task item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'hour': item.hour,
                  'date': item.date,
                  'done': item.done ? 1 : 0,
                  'timeStamp': item.timeStamp
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Task> _taskInsertionAdapter;

  final UpdateAdapter<Task> _taskUpdateAdapter;

  final DeletionAdapter<Task> _taskDeletionAdapter;

  @override
  Future<List<Task>> getAllTasks() async {
    return _queryAdapter.queryList('SELECT * FROM task',
        mapper: (Map<String, Object?> row) => Task(
            id: row['id'] as String,
            name: row['name'] as String,
            done: (row['done'] as int) != 0,
            date: row['date'] as String,
            hour: row['hour'] as String,
            timeStamp: row['timeStamp'] as int));
  }

  @override
  Future<List<Task>> getAllTasksByDate(String date) async {
    return _queryAdapter.queryList('SELECT * FROM task where date = ?1',
        mapper: (Map<String, Object?> row) => Task(
            id: row['id'] as String,
            name: row['name'] as String,
            done: (row['done'] as int) != 0,
            date: row['date'] as String,
            hour: row['hour'] as String,
            timeStamp: row['timeStamp'] as int),
        arguments: [date]);
  }

  @override
  Future<Task?> getTaskById(String id) async {
    return _queryAdapter.query('SELECT * FROM task where id = ?1',
        mapper: (Map<String, Object?> row) => Task(
            id: row['id'] as String,
            name: row['name'] as String,
            done: (row['done'] as int) != 0,
            date: row['date'] as String,
            hour: row['hour'] as String,
            timeStamp: row['timeStamp'] as int),
        arguments: [id]);
  }

  @override
  Future<void> insertTask(Task task) async {
    await _taskInsertionAdapter.insert(task, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateTaskById(Task task) async {
    await _taskUpdateAdapter.update(task, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteTaskById(Task task) async {
    await _taskDeletionAdapter.delete(task);
  }
}
