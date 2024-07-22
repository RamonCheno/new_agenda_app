import 'package:flutter/material.dart';

import 'i_app_theme.dart';
import 'theme.dart';

class AppTheme implements IAppTheme {
  const AppTheme();

  final TextTheme textTheme = const TextTheme();
  @override
  ThemeData darkTheme() {
    MaterialTheme theme = MaterialTheme(textTheme);
    return theme.dark().copyWith(
          appBarTheme: const AppBarTheme(centerTitle: true),
        );
  }

  @override
  ThemeData lightTheme() {
    MaterialTheme theme = MaterialTheme(textTheme);
    return theme
        .light()
        .copyWith(appBarTheme: const AppBarTheme(centerTitle: true));
  }
}
