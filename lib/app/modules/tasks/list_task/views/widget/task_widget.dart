import 'package:new_agenda_app/app/modules/tasks/list_task/controllers/task_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TaskWidget extends StatelessWidget {
  const TaskWidget({
    required this.idTask,
    required this.taskName,
    required this.isDone,
    // required this.index,
    required this.hourTask,
    required this.dateTask,
    this.isViewCalendar = false,
    this.onTap,
    super.key,
  });

  final String hourTask;
  final String dateTask;
  final String idTask;
  final String taskName;
  final bool isDone;
  final bool isViewCalendar;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      key: key,
      title: Text(taskName),
      subtitle: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              // color: Colors.white,
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              // color: Colors.white,
              child: Row(
                children: [
                  const Icon(Icons.today),
                  Text(dateTask),
                ],
              ),
            ),
          ),
          const SizedBox(width: 5),
          Container(
            // padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              // color: Colors.white,
              child: Row(
                children: [
                  const Icon(Icons.alarm_outlined),
                  Text(hourTask),
                ],
              ),
            ),
          ),
        ],
      ),
      onTap: onTap,
      leading: isViewCalendar
          ? null
          : GetBuilder<TasksController>(
              builder: (controller) {
                return Checkbox(
                  value: isDone,
                  onChanged: (value) {
                    if (value != null) {
                      controller.updateTaskDone(idTask, value);
                    }
                  },
                );
              },
            ),
    );
  }
}
