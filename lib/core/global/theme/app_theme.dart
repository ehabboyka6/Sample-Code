import 'package:flutter/material.dart';
import 'package:horsehouse/core/global/theme/theme_data/light.dart';

enum AppTheme {
  light,
}

final Map<AppTheme, ThemeData> appThemeData = {
  AppTheme.light: getThemeDataLight,
};
