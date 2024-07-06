import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_agenda_app/app/core/widgets/bottom_bar_widget.dart';
import 'package:new_agenda_app/app/modules/calendar/calendar.dart';
import 'package:new_agenda_app/app/modules/tasks/tasks.dart';

import '../controllers/home_controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

 @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (controller) {
        return Scaffold(
          body: SafeArea(
              child: IndexedStack(
            index: controller.selectedIndexPage,
            children: const [
              TaskPage(),
              CalendarPage(),
            ],
          )),
          bottomNavigationBar: BottomBarWidget(
            tap: controller.onChangePage,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.check_box_rounded),
                label: 'Tareas',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.calendar_month),
                label: 'Calendario',
              ),
            ],
            selectedIndex: controller.selectedIndexPage,
          ),
        );
      },
    );
  }
}
