import 'home_routes.dart';
import 'task_routes.dart';

class AppPages {
  AppPages._();
  static const initial = '/home';
  
  static final routes = [
    ...HomeRoutes.routes,
    ...TasksRoutes.routes
  ];

}
