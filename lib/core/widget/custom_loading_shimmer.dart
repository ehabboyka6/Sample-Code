import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../utils/app_sizes.dart';

class CustomLoadingShimmer extends StatelessWidget {
  final Color? color;
  final BorderRadiusGeometry? borderRadius;
  final double width;
  final double height;

  const CustomLoadingShimmer(
      {Key? key,
      this.borderRadius,
      required this.width,
      required this.height,
      this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      highlightColor: color != null
          ? color!.withOpacity(0)
          : Theme.of(context).backgroundColor.withOpacity(0),
      baseColor: Theme.of(context).backgroundColor,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
            color: color ?? Theme.of(context).backgroundColor,
            borderRadius: borderRadius ?? BorderRadius.circular(AppSizes.br8)),
      ),
    );
  }
}
