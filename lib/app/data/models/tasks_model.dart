import 'package:floor/floor.dart';

@entity
class Task{
  @primaryKey
  final String id;

  final String name;

  final String hour;

  final String date;

  final bool done;

  final int timeStamp;

  Task({
    required this.id,
    required this.name,
    this.done = false,
    required this.date,
    required this.hour,
    required this.timeStamp
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'timeStamp': timeStamp,
        'name': name,
        'date': date,
        'hour': hour,
        'done': done,
      };

  factory Task.fromMap(Map<String, dynamic> map) => Task(
        id: map['id'] ?? "",
        timeStamp: map['timeStamp'] ?? 0,
        name: map['name'] ?? "",
        date: map['date'] ?? "",
        hour: map['hour'] ?? "",
        done: map['done'] ?? false,
      );

}