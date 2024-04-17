import 'package:flutter/material.dart';

enum DefaultTextStyle {
  displayLarge,
  displaySmall,
  titleSmall,
  bodySmall,
}

class CustomText extends StatelessWidget {
  const CustomText(
    this.text, {
    Key? key,
    this.textStyle,
    this.defaultTextStyle = DefaultTextStyle.titleSmall,
    this.textAlign,
    this.textDirection,
    this.overflow,
    this.maxLines,
  }) : super(key: key);

  ///displayLarge(green Color)
  const CustomText.greenColor(
    String text, {
    Key? key,
    TextAlign? textAlign,
    String? fontFamily,
    int? maxLines,
    TextStyle? textStyle,
    TextOverflow? overflow,
  }) : this(
          text,
          key: key,
          maxLines: maxLines,
          textAlign: textAlign,
          overflow: overflow,
          textStyle: textStyle,
          defaultTextStyle: DefaultTextStyle.displayLarge,
        );

  ///displaySmall(grey color)
  const CustomText.greyColor(
    String text, {
    Key? key,
    TextAlign? textAlign,
    String? fontFamily,
    int? maxLines,
    TextStyle? textStyle,
    TextOverflow? overflow,
    TextDirection? textDirection,
  }) : this(
          text,
          key: key,
          maxLines: maxLines,
          textAlign: textAlign,
          overflow: overflow,
          textDirection: textDirection,
          textStyle: textStyle,
          defaultTextStyle: DefaultTextStyle.displaySmall,
        );

  ///titleSmall(black color)
  const CustomText.blackColor(
    String text, {
    Key? key,
    TextAlign? textAlign,
    String? fontFamily,
    int? maxLines,
    TextStyle? textStyle,
    TextOverflow? overflow,
  }) : this(
          text,
          key: key,
          maxLines: maxLines,
          textAlign: textAlign,
          overflow: overflow,
          textStyle: textStyle,
          defaultTextStyle: DefaultTextStyle.titleSmall,
        );

  ///bodySmall(white color)
  const CustomText.whiteColor(
    String text, {
    Key? key,
    TextAlign? textAlign,
    String? fontFamily,
    int? maxLines,
    TextStyle? textStyle,
    TextOverflow? overflow,
  }) : this(
          text,
          key: key,
          maxLines: maxLines,
          textAlign: textAlign,
          overflow: overflow,
          textStyle: textStyle,
          defaultTextStyle: DefaultTextStyle.bodySmall,
        );

  ///////////////////////////////////////////////////////////////////////

  final String text;
  final TextStyle? textStyle;
  final DefaultTextStyle defaultTextStyle;
  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final TextOverflow? overflow;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: textStyle ?? getDefaultTextStyle(context: context, defaultTextStyle: defaultTextStyle),
      textAlign: textAlign ?? TextAlign.center,
      textDirection: textDirection,
      overflow: overflow,
      maxLines: maxLines,
    );
  }

  TextStyle getDefaultTextStyle({required BuildContext context, required DefaultTextStyle defaultTextStyle}) {
    return {
      DefaultTextStyle.displayLarge: Theme.of(context).textTheme.displayLarge!,
      DefaultTextStyle.displaySmall: Theme.of(context).textTheme.displaySmall!,
      DefaultTextStyle.titleSmall: Theme.of(context).textTheme.titleSmall!,
      DefaultTextStyle.bodySmall: Theme.of(context).textTheme.bodySmall!,
    }[defaultTextStyle]!;
  }
}
