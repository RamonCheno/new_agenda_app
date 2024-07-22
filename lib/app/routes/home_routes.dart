import 'package:get/get.dart';
import 'package:new_agenda_app/app/modules/calendar/calendar.dart';
import 'package:new_agenda_app/app/modules/home/home.dart';
import 'package:new_agenda_app/app/modules/perfil/perfil.dart';
import 'package:new_agenda_app/app/modules/tasks/tasks.dart';

class HomeRoutes {
  HomeRoutes._();

  static const home = '/home';
  static const tasks = '/home/tasks';
  static const calendar = '/home/calendar';
  static const perfil = '/home/perfil';

  static final routes = [
    GetPage(
      name: home,
      page: () => const HomePage(),
      binding: HomeBinding(),
      bindings: [
        TasksBinding(),
        CalendarBinding(),
        PerfilBinding(),
      ],
      children: [
        GetPage(
          name: tasks,
          page: () => const TaskPage(),
          // binding: TasksBinding(),
        ),
        GetPage(
          name: calendar,
          page: () => const CalendarPage(),
          // binding: CalendarBinding(),
        ),
        GetPage(
          name: perfil,
          page: () => const PerfilPage(),
          // binding: TasksBinding(),
        ),
      ],
    ),
  ];
}
