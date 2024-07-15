import 'package:flutter/material.dart';

import 'i_app_theme.dart';

class AppTheme implements IAppTheme {
  
  @override
  ThemeData darkTheme() {
    return ThemeData.dark(useMaterial3: true);
  }

  @override
  ThemeData lightTheme() {
    return ThemeData.light(useMaterial3: true);
  }
}
