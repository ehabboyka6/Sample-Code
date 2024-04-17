import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../utils/app_sizes.dart';

class CustomSvgImage extends StatelessWidget {
  const CustomSvgImage(
      {Key? key,
      required this.path,
      this.height,
      this.width,
      this.radius,
      this.fit = BoxFit.contain,
      this.color})
      : super(key: key);

  CustomSvgImage.square(
      {Key? key, required String path, Color? color, double? size})
      : this(
          key: key,
          path: path,
          height: size ?? AppSizes.pw100,
          width: size ?? AppSizes.pw100,
          color: color,
          radius: BorderRadius.circular(AppSizes.br8),
        );

  CustomSvgImage.icons({Key? key, required String path, Color? color})
      : this(
            key: key,
            path: path,
            height: AppSizes.ph25,
            width: AppSizes.ph25,
            radius: BorderRadius.zero,
            fit: BoxFit.scaleDown,
            color: color ?? Get.theme.iconTheme.color);

  final String path;
  final double? height;
  final double? width;
  final Color? color;
  final BorderRadius? radius;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: radius ?? BorderRadius.zero,
      child: SvgPicture.asset(
        path,
        height: height,
        width: width,
        color: color,
        fit: fit,
      ),
    );
  }
}
