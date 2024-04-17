import 'package:fl_country_code_picker/fl_country_code_picker.dart' as flc;
import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:horsehouse/core/utils/app_constants.dart';
import 'package:horsehouse/features/authentication/presentation/screens/splash_screen.dart';

import 'core/global/localization/all_translation_keys.dart';
import 'core/global/theme/app_theme.dart';
import 'core/services/services_initializer.dart';

///flutter version : 3.13.5
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ServiceInitializer.instance.initializeSettings();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        ///TO Handle keyboard Focus
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: ScreenUtilInit(
        designSize: const Size(428, 926),
        minTextAdapt: false,
        builder: (_, __) {
          return GetMaterialApp(
            localizationsDelegates: const [
              CountryLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            supportedLocales: flc.supportedLocales.map((e) => Locale(e)),
            fallbackLocale: ServiceInitializer.locale,
            title: AppConstance.appName,
            debugShowCheckedModeBanner: false,
            locale: ServiceInitializer.locale,
            translations: LanguageTranslation(),
            theme: appThemeData[AppTheme.light],
            home: const SplashScreen(),
          );
        },
      ),
    );
  }
}
