import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';

import '../global/theme/theme_color/theme_color_light.dart';
import '../utils/app_fonsts.dart';
import '../utils/app_sizes.dart';
import '../utils/enums.dart';
import '../utils/utils.dart';
import 'images/custom_svg_image.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({
    Key? key,
    this.controller,
    this.hintText,
    this.keyTextField,
    this.readonly = false,
    this.obscureText = false,
    this.keyboardType,
    this.textInputAction,
    this.textDirection,
    this.onChanged,
    this.enabled,
    this.onFieldSubmitted,
    this.labelText,
    this.maxLines = 1,
    this.minLines = 1,
    this.maxLength,
    this.inputFormatters,
    this.prefixOnPressed,
    this.suffixOnPressed,
    this.validator,
    this.colorSuffixIcon,
    this.fillColor,
    this.initialValue,
    this.onFocusChange,
    this.prefixIconTextFieldState = IconTextFieldState.empty,
    this.suffixIconTextFieldState = IconTextFieldState.empty,
    this.focusFromStart = false,
    this.withoutFocusBorder = false,
    this.suffix,
  }) : super(key: key);

  final TextEditingController? controller;
  final String? hintText;
  final String? labelText;
  final String? initialValue;
  final String? keyTextField;
  final bool readonly;
  final bool obscureText;
  final Color? colorSuffixIcon;
  final Color? fillColor;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final TextDirection? textDirection;
  final ValueChanged<String>? onChanged;
  final bool? enabled;
  final bool focusFromStart;
  final ValueChanged<String>? onFieldSubmitted;
  final int? maxLines;
  final int? minLines;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;
  final void Function()? prefixOnPressed;
  final void Function()? suffixOnPressed;
  final String? Function(String?)? validator;
  final IconTextFieldState prefixIconTextFieldState;
  final IconTextFieldState suffixIconTextFieldState;
  final void Function(bool)? onFocusChange;
  final bool withoutFocusBorder;
  final Widget? suffix;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  FocusNode focusNode = FocusNode();
  bool hasError = false;

  @override
  void initState() {
    super.initState();
    if (widget.focusFromStart) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        FocusScope.of(context).requestFocus(focusNode);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: (focus) {
        setState(() {});
        if (widget.onFocusChange != null) widget.onFocusChange!(focus);
      },
      child: TextFormField(
          initialValue: widget.initialValue,
          readOnly: widget.readonly,
          controller: widget.controller,
          maxLines: widget.maxLines,
          minLines: widget.minLines,
          keyboardType: widget.keyboardType,
          textInputAction: widget.textInputAction,
          validator: (value) {
            if (widget.validator == null) return null;
            setState(() {
              hasError = widget.validator!(value) != null;
            });
            return widget.validator!(value);
          },
          style: Theme.of(context).textTheme.labelMedium!.copyWith(
                fontSize: AppSizes.sp16,
                fontWeight: AppFonts.medium,
              ),
          textDirection: widget.textDirection,
          inputFormatters: widget.inputFormatters,
          onChanged: widget.onChanged,
          enabled: widget.enabled,
          focusNode: focusNode,
          maxLength: widget.maxLength,
          cursorColor: Theme.of(context).inputDecorationTheme.focusedBorder!.borderSide.color,
          onFieldSubmitted: widget.onFieldSubmitted,
          obscureText: widget.obscureText,
          key: ValueKey(widget.keyTextField),
          decoration: (const InputDecoration()).applyDefaults(Theme.of(context).inputDecorationTheme).copyWith(
                counterText: "",
                counterStyle: const TextStyle(
                  height: double.minPositive,
                ),
                fillColor: widget.fillColor ?? Theme.of(context).inputDecorationTheme.fillColor,
                filled: true,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: AppSizes.pw16,
                  vertical: AppSizes.ph12,
                ),
                focusedBorder: !widget.withoutFocusBorder
                    ? Theme.of(context).inputDecorationTheme.focusedBorder
                    : OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: ThemeColorLight.transparentColor,
                          width: 0,
                        ),
                        borderRadius: BorderRadius.circular(AppSizes.br16),
                      ),
                enabledBorder: !widget.withoutFocusBorder
                    ? Theme.of(context).inputDecorationTheme.enabledBorder
                    : OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: ThemeColorLight.transparentColor,
                          width: 0,
                        ),
                        borderRadius: BorderRadius.circular(AppSizes.br16),
                      ),
                errorBorder: !widget.withoutFocusBorder
                    ? Theme.of(context).inputDecorationTheme.errorBorder
                    : OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: ThemeColorLight.transparentColor,
                          width: 0,
                        ),
                        borderRadius: BorderRadius.circular(AppSizes.br16),
                      ),
                border: !widget.withoutFocusBorder
                    ? Theme.of(context).inputDecorationTheme.border
                    : OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: ThemeColorLight.transparentColor,
                          width: 0,
                        ),
                        borderRadius: BorderRadius.circular(AppSizes.br16),
                      ),
                focusedErrorBorder: !widget.withoutFocusBorder
                    ? Theme.of(context).inputDecorationTheme.focusedErrorBorder
                    : OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: ThemeColorLight.transparentColor,
                          width: 0,
                        ),
                        borderRadius: BorderRadius.circular(AppSizes.br16),
                      ),
                hintText: widget.hintText ?? "",
                hintStyle: Theme.of(context).inputDecorationTheme.hintStyle,
                labelText: widget.labelText,
                labelStyle: Theme.of(context).inputDecorationTheme.labelStyle,
                floatingLabelStyle: hasError
                    ? Theme.of(context).inputDecorationTheme.errorStyle!.copyWith(fontSize: AppSizes.sp14)
                    : focusNode.hasFocus
                        ? Theme.of(context).inputDecorationTheme.floatingLabelStyle!.copyWith(fontSize: AppSizes.sp14)
                        : Theme.of(context).inputDecorationTheme.labelStyle!.copyWith(fontSize: AppSizes.sp14),
                suffixIcon: widget.suffixIconTextFieldState != IconTextFieldState.empty
                    ? (widget.suffix) ??
                        IconButton(
                          icon: CustomSvgImage.icons(
                            path: iconTextFieldPath[widget.suffixIconTextFieldState]!,
                            color: Theme.of(context).iconTheme.color,
                          ),
                          onPressed: widget.suffixOnPressed,
                        )
                    : null,
                prefixIcon: widget.prefixIconTextFieldState != IconTextFieldState.empty
                    ? IconButton(
                        onPressed: widget.prefixOnPressed,
                        icon: CustomSvgImage.icons(
                          path: iconTextFieldPath[widget.prefixIconTextFieldState]!,
                          color: Theme.of(context).iconTheme.color,
                        ),
                      )
                    : null,
                errorStyle: Theme.of(context).inputDecorationTheme.errorStyle,
                disabledBorder: Theme.of(context).inputDecorationTheme.disabledBorder,
              )),
    );
  }
}
