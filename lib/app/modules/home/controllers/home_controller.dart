import 'package:get/get.dart';

class HomeController extends GetxController {
  int selectedIndexPage = 0;

  void onChangePage(int value) {
    selectedIndexPage = value;
    update();
  }
}
