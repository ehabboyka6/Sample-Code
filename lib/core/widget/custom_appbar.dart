import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../global/localization/app_localization.dart';
import '../global/theme/theme_color/theme_color_light.dart';
import '../services/dependency_injection_services.dart';
import '../services/navigation_services.dart';
import '../utils/app_assets.dart';
import '../utils/app_sizes.dart';
import 'custom_text.dart';
import 'images/custom_svg_image.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  final bool canPop;
  final bool withTransparent;
  final bool withMenu;
  final bool withOutElevation;
  final bool withDivider;
  final bool withOutContent;
  final void Function()? popOnPressed;
  final String? title;
  final bool centerTitle;
  final List<Widget> actions;
  final PreferredSizeWidget? bottom;

  const CustomAppbar({
    Key? key,
    this.canPop = true,
    this.withMenu = false,
    this.withOutContent = false,
    this.popOnPressed,
    this.title,
    this.centerTitle = true,
    this.actions = const <Widget>[],
    this.withTransparent = false,
    this.withOutElevation = false,
    this.withDivider = false,
    this.bottom,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      bottom: bottom ?? (withDivider ? const BottomDividerAppBar() : bottom),
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      backgroundColor:
          withTransparent ? ThemeColorLight.transparentColor : Theme.of(context).appBarTheme.backgroundColor,
      automaticallyImplyLeading: false,
      actions: [
        Expanded(
          child: withOutContent
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: actions,
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ///Back Button
                    if (canPop) CustomBackButton(popOnPressed: popOnPressed),

                    ///Title
                    Expanded(
                        child: title != null
                            ? Align(
                                alignment: centerTitle ? Alignment.center : AlignmentDirectional.centerStart,
                                child: Padding(
                                  padding: centerTitle &&
                                          ((canPop && !withMenu && actions.isEmpty) ||
                                              (!canPop && withMenu && actions.isEmpty) ||
                                              (!canPop && !withMenu && actions.isNotEmpty))
                                      ? EdgeInsetsDirectional.only(
                                          end: canPop && (actions.isEmpty || !withMenu)
                                              ? AppSizes.ph35 + (AppSizes.pw16)
                                              : 0,
                                          start: !canPop && (withMenu || actions.isNotEmpty)
                                              ? AppSizes.ph35 + (AppSizes.pw16)
                                              : 0)
                                      : EdgeInsets.zero,
                                  child: CustomText(
                                    title!,
                                    textStyle: Theme.of(context).appBarTheme.titleTextStyle,
                                    maxLines: 1,
                                  ),
                                ))
                            : const SizedBox()),

                    ///actions
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: withMenu
                          ? [
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [...actions],
                              ),
                              Container(
                                margin: EdgeInsetsDirectional.only(end: AppSizes.pw16),
                                height: AppSizes.ph35,
                                width: AppSizes.ph35,
                                child: IconButton(
                                  padding: EdgeInsets.zero,
                                  constraints: const BoxConstraints(),
                                  onPressed: () {},
                                  icon: CustomSvgImage(
                                    path: AppAssets.menuIcon,
                                    width: AppSizes.ph35,
                                    height: AppSizes.ph35,
                                    radius: BorderRadius.zero,
                                  ),
                                ),
                              )
                            ]
                          : actions,
                    ),
                  ],
                ),
        ),
      ],
      elevation: withOutElevation ? 0 : 3,
      shadowColor: Colors.black38,
      toolbarHeight: AppSizes.ph64,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(AppSizes.ph64);
}

class CustomBackButton extends StatelessWidget {
  final void Function()? popOnPressed;
  final Color? color;
  final EdgeInsetsGeometry? margin;

  const CustomBackButton({Key? key, this.popOnPressed, this.color, this.margin}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? EdgeInsetsDirectional.only(start: AppSizes.pw16),
      width: AppSizes.ph35,
      height: AppSizes.ph35,
      child: IconButton(
        padding: EdgeInsets.zero,
        constraints: const BoxConstraints(),
        onPressed: () {
          if (popOnPressed != null) {
            popOnPressed!();
          } else {
            NavigationService.goBack();
          }
        },
        icon: sl<BaseAppLocalizations>().isEnglish()
            ? CustomSvgImage(
                path: AppAssets.backSvg,
                color: color ?? Theme.of(context).iconTheme.color,
                width: AppSizes.ph35,
                height: AppSizes.ph35,
                radius: BorderRadius.zero,
                fit: BoxFit.scaleDown,
              )
            : Transform.rotate(
                angle: 180 * math.pi / 180,
                child: CustomSvgImage(
                  path: AppAssets.backSvg,
                  color: color ?? Theme.of(context).iconTheme.color,
                  width: AppSizes.ph35,
                  height: AppSizes.ph35,
                  radius: BorderRadius.zero,
                  fit: BoxFit.scaleDown,
                )),
      ),
    );
  }
}

class BottomDividerAppBar extends StatelessWidget implements PreferredSizeWidget {
  const BottomDividerAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Divider(color: ThemeColorLight.greyShadow.withOpacity(0.5), height: AppSizes.zero, thickness: 0.6);
  }

  @override
  Size get preferredSize => Size.fromHeight(AppSizes.ph64);
}
