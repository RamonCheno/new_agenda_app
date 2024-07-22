import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/perfil_controller.dart';

class PerfilPage extends GetView<PerfilController> {
  const PerfilPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Resumen de tareas",
                        style: Theme.of(context).textTheme.headlineMedium),
                  ],
                ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Ajustes",
                        style: Theme.of(context).textTheme.headlineMedium),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Tema: ",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(width: 5),
                    Row(
                      children: [
                        Icon(
                          AdaptiveTheme.of(context).mode.isLight
                              ? Icons.light_mode_outlined
                              : AdaptiveTheme.of(context).mode.isDark
                                  ? Icons.dark_mode_outlined
                                  : Icons.brightness_auto_outlined,
                        ),const SizedBox(width: 5),
                        Obx(
                          () {
                            return DropdownButton<String>(
                              value: controller.selectedTheme.value != ""
                                  ? controller.selectedTheme.value
                                  : "Claro",
                              items: controller.optionsTheme
                                  .map<DropdownMenuItem<String>>(
                                    (String value) => DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(
                                        value,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge,
                                      ),
                                    ),
                                  )
                                  .toList(),
                              onChanged: (String? newValue) {
                                controller.changeValueTheme(context, newValue);
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
