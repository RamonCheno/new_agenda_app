import 'package:get/get.dart';

import '../modules/calendar/calendar.dart';
import '../modules/home/home.dart';
import '../modules/tasks/tasks.dart';

class HomeRoutes {
  HomeRoutes._();

  static const home = '/home';
  static const tasks = '/home/tasks';
  static const calendar = '/home/calendar';

  static final routes = [
    GetPage(
      name: home,
      page: () => const HomePage(),
      binding: HomeBinding(),
      bindings: [
        TasksBinding(),
        CalendarBinding(),
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
      ],
    ),
  ];
}
