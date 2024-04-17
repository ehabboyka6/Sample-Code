import 'package:flutter/material.dart';

import '../services/navigation_services.dart';
import '../utils/app_sizes.dart';
import 'custom_dialog.dart';

class DialogWidget {
  static Future showCustomDialog(
      {required BuildContext context,
      String? title,
      String? message,
      String? buttonName,
      Function? onClickButton,
      String? image,
      Widget? child,
      List<Widget>? actions,
      bool barrierDismissible = true,
      }) async {
    return await showGeneralDialog(
        context: context,
        barrierDismissible: barrierDismissible,
        transitionBuilder: (context, a1, a2, widget) => Transform.scale(
              scale: a1.value,
              child: WillPopScope(
                onWillPop: () => Future.value(barrierDismissible),
                child: Opacity(
                  opacity: a1.value,
                  child: CustomDialog(
                    context: context,
                    title: title,
                    actions: actions,
                    image: image,
                    onClickButton: onClickButton ?? NavigationService.goBack,
                    message: message,
                    buttonName: buttonName,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppSizes.br20)),
                    child: child,
                  ),
                ),
              ),
            ),
        pageBuilder: (BuildContext context, Animation<double> animation,
                Animation<double> secondaryAnimation) =>
            const SizedBox());
  }
}
