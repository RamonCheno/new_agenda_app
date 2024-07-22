import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:new_agenda_app/app/data/dto/task_dto.dart';
import '../controllers/task_controller.dart';
import 'widget/task_widget.dart';

class TaskPage extends GetView<TasksController> {
  const TaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(controller.title),
      ),
      body: Center(
        child: Obx(
          () {
            return controller.listTaskDto.isEmpty
                ? const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: CircularProgressIndicator(),
                      ),
                      Center(
                        child: Text(
                          'No hay tareas',
                          style: TextStyle(
                            fontSize: 20
                          ),
                        ),
                      ),
                    ],
                  )
                : Column(
                    children: [
                      Expanded(
                        child: ListView.separated(
                          itemBuilder: (_, index) {
                            TaskDto taskDto = controller.listTaskDto[index];
                            return Slidable(
                              key: Key(taskDto.id!),
                              endActionPane: ActionPane(
                                motion: const BehindMotion(),
                                children: [
                                  SlidableAction(
                                    backgroundColor: Colors.red,
                                    icon: Icons.delete,
                                    label: "Eliminar",
                                    onPressed: (_) {
                                      String uuid = taskDto.id!;
                                      controller.confirmDeleteTask(uuid);
                                    },
                                  ),
                                ],
                              ),
                              child: Card(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: TaskWidget(
                                  idTask: taskDto.id!,
                                  taskName: taskDto.nameTask,
                                  isDone: taskDto.isDoneObs,
                                  dateTask: taskDto.dateTask!,
                                  hourTask: taskDto.hourTask!,
                                  key: Key(taskDto.id!),
                                  onTap: () {
                                    // TaskDto? taskDtoSelect = await controller
                                    //     .getTaskById(taskDto.id!);
                                    // if (taskDtoSelect != null) {.
                                    Map<String, dynamic> taskSelectMap =
                                        taskDto.toMap();
                                    debugPrint(
                                        "Tarea seleccionada: ${taskSelectMap['id']}");
                                    Get.toNamed('/tasks/update-task',
                                        arguments: taskSelectMap);
                                    // }
                                  },
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (_, index) {
                            return const SizedBox(
                              height: 10,
                            );
                          },
                          itemCount: controller.listTaskDto.length,
                        ),
                      ),
                    ],
                  );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Get.toNamed("/tasks/add-task");
        },
      ),
    );
  }
}
