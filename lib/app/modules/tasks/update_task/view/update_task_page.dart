
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_agenda_app/app/core/widgets/textfieldform_widget.dart';

import '../controllers/update_task_controller.dart';

class UpdateTaskPage extends GetView<UpdateTaskController> {
  const UpdateTaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar tarea'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Resumen de la tarea:",
                  ),
                  Container(
                    margin: const EdgeInsets.all(10),
                    // color: Colors.blue[50],
                    // padding: const EdgeInsets.all(10),
                    child: Form(
                      child: CustomTextfieldformWidget(
                        hintName: "Nombre de la tarea",
                        textController: controller.updateTaskController,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Icon(Icons.calendar_month),
                  const SizedBox(width: 2),
                  const Text("Fecha de la cita:"),
                  const SizedBox(width: 5),
                  TextButton(
                    style: ButtonStyle(
                      overlayColor:
                          WidgetStateProperty.all(Colors.transparent),
                    ),
                    onPressed: () {
                      controller.selectDate(context);
                    },
                    child: Obx(
                      () {
                        return Text(controller.dayTaskFormat != ""
                            ? controller.dayTaskFormat
                            : "Sin Cita");
                      },
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  const Icon(Icons.calendar_month),
                  const SizedBox(width: 2),
                  const Text("Hora de la cita:"),
                  const SizedBox(width: 5),
                  TextButton(
                    style: ButtonStyle(
                      overlayColor:
                          WidgetStateProperty.all(Colors.transparent),
                    ),
                    onPressed: () {
                      controller.selectTime(context);
                    },
                    child: Obx(
                      () {
                        return Text(controller.hourTaskFormat != ""
                            ? controller.hourTaskFormat
                            : "Sin hora");
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.save_outlined),
        onPressed: () {
          String editNameTask = controller.updateTaskController.text;
          String dateTaskSelected = controller.dayTaskFormat;
          String hourTaskSelected = controller.hourTaskFormat;
          controller.editTask(editNameTask,
              dateTask: dateTaskSelected, hourTask: hourTaskSelected);
          Get.back();
        },
      ),
    );
  }
}
