import 'package:flutter/material.dart';
import 'package:horsehouse/core/utils/app_string.dart';

import '../global/localization/app_localization.dart';
import '../utils/app_fonsts.dart';
import '../utils/app_sizes.dart';
import 'custom_elevated_button.dart';
import 'custom_text.dart';
import 'images/custom_svg_image.dart';

class CustomDialog extends AlertDialog {
  CustomDialog({
    Key? key,
    required BuildContext context,
    String? image,
    required Function onClickButton,
    String? title,
    String? message,
    String? buttonName,
    List<Widget>? actions,
    EdgeInsets? insetPadding,
    ShapeBorder? shape,
    Widget? child,
  }) : super(
            key: key,
            shape: shape,
            backgroundColor: Theme.of(context).cardColor,
            insetPadding: insetPadding ?? EdgeInsets.symmetric(horizontal: AppSizes.pw12),
            content: child ??
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (image != null)
                      CustomSvgImage.square(
                        path: image,
                      ),
                    SizedBox(
                      height: AppSizes.pw12,
                    ),
                    if (title != null)
                      CustomText.blackColor(
                        title,
                        textStyle: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .copyWith(fontWeight: AppFonts.semiBold, fontSize: AppSizes.sp18),
                      ),
                    SizedBox(
                      height: AppSizes.ph14,
                    ),
                    if (message != null)
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: AppSizes.pw32),
                        child: CustomText.greyColor(
                          message,
                          textStyle: Theme.of(context)
                              .textTheme
                              .displaySmall!
                              .copyWith(fontWeight: AppFonts.normal, fontSize: AppSizes.sp16),
                        ),
                      ),
                    if (message != null)
                      SizedBox(
                        height: AppSizes.ph14,
                      ),
                    child ?? const SizedBox(),
                    if (actions != null) ...List.generate(actions.length, (index) => actions[index]),
                    if (actions == null)
                      SizedBox(
                          width: double.infinity,
                          child: CustomElevatedButton(
                            text: buttonName ?? tr(AppString.submit),
                            onPressed: onClickButton,
                          ))
                  ],
                ));
}
