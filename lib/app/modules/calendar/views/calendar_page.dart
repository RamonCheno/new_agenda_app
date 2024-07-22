import 'package:new_agenda_app/app/data/dto/task_dto.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../tasks/list_task/views/widget/task_widget.dart';
import '../controllers/calendar_controller.dart';

class CalendarPage extends GetView<CalendarController> {
  const CalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(controller.title),
      ),
      body: Column(
        children: [
          Flexible(
            child: CalendarDatePicker(
              initialDate: controller.dayTask,
              firstDate: DateTime(2024),
              lastDate: DateTime(2099),
              currentDate: controller.dayTask,
              onDateChanged: controller.onDateChanged,
            ),
          ),
          Obx(
            () {
              if (controller.listTaskDtoByDate.isEmpty) {
                return const Flexible(
                  child: Column(
                    children: [
                      Center(
                        child: CircularProgressIndicator(),
                      ),
                      Center(
                        child: Text(
                          'No hay tareas para el dia seleccionado',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return Flexible(
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.separated(
                          itemBuilder: (_, index) {
                            TaskDto taskDto =
                                controller.listTaskDtoByDate[index];
                            return Card(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: TaskWidget(
                                idTask: taskDto.id!,
                                taskName: taskDto.nameTask,
                                isDone: taskDto.isDoneObs,
                                // index: index,
                                dateTask: taskDto.dateTask!,
                                hourTask: taskDto.hourTask!,
                                isViewCalendar: true,
                                key: Key(taskDto.id!),
                              ),
                            );
                          },
                          separatorBuilder: (_, index) => const SizedBox(
                            height: 10,
                          ),
                          itemCount: controller.listTaskDtoByDate.length,
                        ),
                      ),
                    ],
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
