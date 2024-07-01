import 'package:get/get.dart';
import 'package:new_agenda_app/app/modules/home/home.dart';

class HomeRoutes {
  HomeRoutes._();

  static const home = '/home';
  static const tasks = '/home/tasks';
  static const calendar = '/home/calendart';

  static final routes = [GetPage(name: home, page: () => const HomePage())];
}
