import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ComponentsUtil {
  static void showSnackBar(
      String title, String message, Color backgroundColor) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: backgroundColor,
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
    );
  }

  static void showDeleteDialog(VoidCallback onConfirm) {
    Get.defaultDialog(
      title: "Eliminar Elemento",
      middleText: "¿Estás seguro de que deseas eliminar este elemento?",
      textConfirm: "Eliminar",
      textCancel: "Cancelar",
      confirmTextColor: Colors.white,
      cancelTextColor: Colors.black,
      buttonColor: Colors.red,
      onConfirm: () {
        onConfirm();
        Get.back();
      },
      onCancel: () {
        Get.back();
      },
    );
  }
}
