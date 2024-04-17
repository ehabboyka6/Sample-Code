import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../utils/app_sizes.dart';

class CustomLoadingIndicators {

  static Widget defaultLoading({double? size, Color? color}) {
    return SizedBox(
      width: size ?? AppSizes.ph50,
      height: size ?? AppSizes.ph50,
      child: Center(
          child: CircularProgressIndicator(
        strokeWidth: AppSizes.ph1,
        color: color ?? Theme.of(Get.context!).progressIndicatorTheme.color,
      )),
    );
  }
}
