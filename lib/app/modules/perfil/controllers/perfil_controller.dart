import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PerfilController extends GetxController {
  List<String> optionsTheme = ["Claro", "Auto", "Oscuro"];
  RxString selectedTheme = "".obs;

  void changeValueTheme(BuildContext context, String? newTheme) {
    if (newTheme == null) return;
    selectedTheme.value = newTheme;
    switch (selectedTheme.value) {
      case 'Auto':
        AdaptiveTheme.of(context).setSystem();
        break;
      case 'Claro':
        AdaptiveTheme.of(context).setLight();
        break;
      case 'Oscuro':
        AdaptiveTheme.of(context).setDark();
        break;
    }
  }
}
