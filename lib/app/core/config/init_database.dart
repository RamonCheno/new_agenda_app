import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_agenda_app/app/data/database/database.dart';

class InitDatabase {
  static Future<void> initDatabase() async {
    await Get.putAsync<DatabaseHelper>(
      () async => await DatabaseHelper.init(),
      permanent: true,
    );

    debugPrint("Base de datos inicializado");
  }
}
