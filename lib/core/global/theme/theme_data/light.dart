import 'package:flutter/material.dart';

import '../../../utils/app_fonsts.dart';
import '../../../utils/app_sizes.dart';
import '../theme_color/theme_color_light.dart';

ThemeData get getThemeDataLight => ThemeData(
      fontFamily: AppFonts.getAppFont,
      backgroundColor: ThemeColorLight.backgroundColor,
      cardColor: ThemeColorLight.containerCardColor,
      dialogBackgroundColor: ThemeColorLight.dialogBackgroundColor,
      disabledColor: ThemeColorLight.disableColor,
      brightness: Brightness.light,
      errorColor: ThemeColorLight.errorColor,

      ///ProgressIndicator
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: ThemeColorLight.greenColor,
      ),

      ///icon
      iconTheme: const IconThemeData(color: ThemeColorLight.iconColor),

      /// TextFormField
      inputDecorationTheme: InputDecorationTheme(
          fillColor: ThemeColorLight.transparentColor,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: ThemeColorLight.searchFormFieldColor,
              width: AppSizes.bs1_0,
            ),
            borderRadius: BorderRadius.circular(AppSizes.br4),
          ),
          hintStyle: TextStyle(
              color: ThemeColorLight.hintTextFieldColor, fontWeight: AppFonts.regular, fontSize: AppSizes.sp14),
          outlineBorder: BorderSide(
            color: ThemeColorLight.searchFormFieldColor,
            width: AppSizes.bs1_0,
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: ThemeColorLight.errorColor,
              width: AppSizes.bs1_0,
            ),
            borderRadius: BorderRadius.circular(AppSizes.br4),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: ThemeColorLight.searchFormFieldColor,
              width: AppSizes.bs1_0,
            ),
            borderRadius: BorderRadius.circular(AppSizes.br4),
          ),
          floatingLabelStyle:
              TextStyle(color: ThemeColorLight.greenColor, fontWeight: AppFonts.medium, fontSize: AppSizes.sp12),
          errorStyle: TextStyle(
            color: ThemeColorLight.errorColor,
            fontSize: AppSizes.sp12,
            fontWeight: AppFonts.regular,
            fontFamily: AppFonts.getAppFont,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: ThemeColorLight.greenColor,
              width: AppSizes.bs0_8,
            ),
            borderRadius: BorderRadius.circular(AppSizes.br4),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: ThemeColorLight.errorColor,
              width: AppSizes.bs1_0,
            ),
          ),
          labelStyle: TextStyle(
            color: ThemeColorLight.labelTextFieldColor,
            fontSize: AppSizes.sp16,
            fontWeight: AppFonts.regular,
            fontFamily: AppFonts.getAppFont,
          )),

      ///AppBar
      appBarTheme: AppBarTheme(
        backgroundColor: ThemeColorLight.containerCardColor,
        titleTextStyle: TextStyle(
          color: ThemeColorLight.appBarTitleColor,
          fontFamily: AppFonts.getAppFont,
          fontWeight: AppFonts.medium,
          fontSize: AppSizes.sp18,
        ),
      ),

      ///elevated Button
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(const EdgeInsets.all(0)),
            backgroundColor: MaterialStateProperty.all<Color>(ThemeColorLight.greenColor),
            overlayColor: MaterialStateProperty.all<Color>(ThemeColorLight.greenColor),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSizes.br8),
            ))),
      ),

      hintColor: ThemeColorLight.lightGray,
      textTheme: getTextTheme(),
      cardTheme: const CardTheme(elevation: 15),
    );

TextTheme getTextTheme() => TextTheme(
      /// grey
      displaySmall: TextStyle(
        color: ThemeColorLight.secondaryColor,
        fontSize: AppSizes.sp14,
        fontWeight: AppFonts.regular,
        fontFamily: AppFonts.getAppFont,
      ),

      /// black
      titleSmall: TextStyle(
        color: ThemeColorLight.blackColor,
        fontSize: AppSizes.sp14,
        fontWeight: AppFonts.semiBold,
        fontFamily: AppFonts.getAppFont,
      ),

      /// green
      displayMedium: TextStyle(
        color: ThemeColorLight.greenColor,
        fontSize: AppSizes.sp14,
        fontWeight: AppFonts.medium,
        fontFamily: AppFonts.getAppFont,
      ),

      /// white
      bodySmall: TextStyle(
        color: ThemeColorLight.whiteColor,
        fontSize: AppSizes.sp18,
        fontWeight: AppFonts.medium,
        fontFamily: AppFonts.getAppFont,
      ),
    );
