import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:new_agenda_app/app/core/config/init_database.dart';
import 'package:new_agenda_app/app/core/services/notification_services.dart';
import 'package:new_agenda_app/app/core/theme/app_theme.dart';
import 'package:new_agenda_app/app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final savedThemeMode = await AdaptiveTheme.getThemeMode();
  await InitDatabase.initDatabase();
  await NotificationService.initLocalNotification();
  runApp(MyApp(savedThemeMode: savedThemeMode));
}

class MyApp extends StatelessWidget {
  final AdaptiveThemeMode? savedThemeMode;
  const MyApp({super.key, this.savedThemeMode});

  @override
  Widget build(BuildContext context) {
    const AppTheme appTheme = AppTheme();
    return AdaptiveTheme(
      light: appTheme.lightTheme(),
      dark: appTheme.darkTheme(),
      initial: savedThemeMode ?? AdaptiveThemeMode.light,
      builder: (light, dark) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Agenda de recordatorios',
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const <Locale>[
          Locale('en', 'US'),
          Locale('es', 'US'),
        ],
        darkTheme: dark,
        theme: light,
        initialRoute: AppPages.initial,
        getPages: AppPages.routes,
      ),
    );
  }
}
