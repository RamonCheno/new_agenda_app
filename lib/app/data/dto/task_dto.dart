import 'package:get/get.dart';

class TaskDto {
  String? id;

  String nameTask;

  String? hourTask;

  String? dateTask;

  int? timeStamp;

  final RxBool _isDoneObs = false.obs;

  bool get isDoneObs => _isDoneObs.value;

  set isDoneObs(bool value) => _isDoneObs.value = value;

  TaskDto(
      {this.id,
      this.timeStamp,
      required this.nameTask,
      bool isDone = false,
      this.hourTask,
      this.dateTask}) {
    _isDoneObs.value = isDone;
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'timeStamp': timeStamp,
        'name': nameTask,
        'date': dateTask,
        'hour': hourTask,
        'done': _isDoneObs.value,
      };

  factory TaskDto.fromMap(Map<String, dynamic> map) => TaskDto(
        id: map['id'],
        timeStamp: map['timeStamp'],
        nameTask: map['name'],
        dateTask: map['date'],
        hourTask: map['hour'],
        isDone: map['done'],
      );
}
