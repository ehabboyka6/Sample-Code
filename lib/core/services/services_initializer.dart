import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../global/localization/app_localization.dart';
import '../global/theme/app_theme.dart';
import 'dependency_injection_services.dart';

class ServiceInitializer {
  ServiceInitializer._();

  static final ServiceInitializer instance = ServiceInitializer._();

  static late Locale locale;
  static late AppTheme savedAppTheme;

  initializeSettings() async {
    await initializeDependencyInjection();
    List futures = [
      initializeScreensOrientation(),
      getSavedLocal(),
      initializeFirebase(),
    ];
    await Future.wait<dynamic>([...futures]);
  }

  initializeDependencyInjection() async {
    await DependencyInjectionServices().init();
  }

  initializeScreensOrientation() async {
    await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
    );
  }

  Future getSavedLocal() async {
    locale = await sl<BaseAppLocalizations>().getUserStoredLocale();
  }

  Future initializeFirebase() async {
    await Firebase.initializeApp();
  }
}
