import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_agenda_app/app/modules/calendar/calendar.dart';
import 'package:new_agenda_app/app/modules/perfil/perfil.dart';
import 'package:new_agenda_app/app/modules/tasks/tasks.dart';

class HomeController extends GetxController {
  int selectedIndexPage = 0;

  List<Widget> pages = [
    const TaskPage(),
    const CalendarPage(),
    const PerfilPage(),
  ];

  void onChangePage(int value) {
    selectedIndexPage = value;
    update();
  }
}
