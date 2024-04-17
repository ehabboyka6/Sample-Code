import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:horsehouse/core/utils/app_fonsts.dart';

import '../utils/app_sizes.dart';

class CustomLink extends StatelessWidget {
  final String prefixText;
  final String linkText;
  final void Function()? linkAction;
  final TextStyle? prefixStyle;

  const CustomLink({Key? key, required this.prefixText, required this.linkText, this.linkAction, this.prefixStyle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: linkAction,
      child: RichText(
          text: TextSpan(children: [
        TextSpan(
            text: prefixText,
            style: prefixStyle ??
                Theme.of(context)
                    .textTheme
                    .displaySmall!
                    .copyWith(fontSize: AppSizes.sp14, fontWeight: AppFonts.regular)),
        if (prefixText.isNotEmpty)
          WidgetSpan(
            child: SizedBox(width: AppSizes.pw8),
          ),
        TextSpan(
          text: linkText,
          style:
              Theme.of(context).textTheme.displayMedium!.copyWith(fontSize: AppSizes.sp14, fontWeight: AppFonts.regular),
          recognizer: TapGestureRecognizer()..onTap = linkAction,
        ),
      ])),
    );
  }
}
