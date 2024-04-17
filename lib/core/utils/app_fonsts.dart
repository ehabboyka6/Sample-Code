import 'package:flutter/cupertino.dart';

import '../global/localization/app_localization.dart';

class AppFonts {
  static const String fontFamilyEnglish = "Poppins-Regular";
  static const String fontArabic = "SF-Arabic-font";

  static get getAppFont => AppLocalizations().isArabic()
      ? AppFonts.fontArabic
      : AppFonts.fontFamilyEnglish;

  /// Font Weight
  static const FontWeight bold = FontWeight.bold;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight regular = FontWeight.normal;
  static const FontWeight normal = FontWeight.w400;
}
