import 'package:flutter/material.dart';
import 'package:horsehouse/core/widget/custom_loading_indicator.dart';

import '../global/theme/theme_color/theme_color_light.dart';
import '../utils/app_sizes.dart';
import 'custom_text.dart';
import 'images/custom_svg_image.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton(
      {Key? key,
      required this.onPressed,
      required this.text,
      this.isEnabled = true,
      this.isLoading = false,
      this.iconAsset})
      : super(key: key);

  final bool isEnabled;
  final Function onPressed;
  final String text;
  final bool isLoading;
  final String? iconAsset;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isEnabled && !isLoading
          ? () {
              onPressed.call();
            }
          : null,
      style: isEnabled
          ? Theme.of(context).elevatedButtonTheme.style
          : Theme.of(context).elevatedButtonTheme.style!.copyWith(
                backgroundColor: MaterialStateProperty.all<Color>(
                  Theme.of(context).disabledColor,
                ),
              ),
      child: SizedBox(
        height: AppSizes.ph52,
        child: Ink(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.transparent),
              gradient: LinearGradient(
                colors: isEnabled
                    ? [
                        ThemeColorLight.greenColor,
                        ThemeColorLight.successColor,
                      ]
                    : [Theme.of(context).disabledColor, Theme.of(context).disabledColor],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(AppSizes.br8)),
          child: Container(
            constraints: const BoxConstraints(maxHeight: 43),
            padding: EdgeInsets.symmetric(horizontal: AppSizes.pw18),
            alignment: Alignment.center,
            child: isLoading
                ? CustomLoadingIndicators.defaultLoading(
                    color: ThemeColorLight.loadingColorElevatedButton,
                    size: AppSizes.ph15,
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (iconAsset != null)
                        Row(
                          children: [
                            CustomSvgImage.icons(path: iconAsset!, color: Theme.of(context).iconTheme.color),
                            SizedBox(
                              width: AppSizes.pw16,
                            )
                          ],
                        ),
                      CustomText.greyColor(
                        text,
                        textStyle: Theme.of(context).textTheme.displaySmall!.copyWith(
                              color: ThemeColorLight.elevatedButtonTextColor,
                              fontSize: AppSizes.sp16,
                              height: 1.2,
                            ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
