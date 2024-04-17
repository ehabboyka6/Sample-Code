import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';

class StatusBarManager {
  static setTransparentWithNormalIconColor({required BuildContext context}) async {
    await FlutterStatusbarcolor.setStatusBarColor(Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
  }

  static setTransparentWithAbnormalIconColor({required BuildContext context}) async {
    await FlutterStatusbarcolor.setStatusBarColor(Colors.transparent);

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
  }

  static setLikeAppBarColor({required BuildContext context}) async {
    await FlutterStatusbarcolor.setStatusBarColor(Theme.of(context).appBarTheme.backgroundColor!);

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
  }

  static setLikeBackgroundColor(
      {required BuildContext context, Color? backgroundColor, bool reverseIconColor = false}) async {
    await FlutterStatusbarcolor.setStatusBarColor(backgroundColor ?? Theme.of(context).backgroundColor);

    SystemChrome.setSystemUIOverlayStyle(reverseIconColor ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark);
  }
}
