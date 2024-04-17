import 'package:flutter/material.dart';

import '../../utils/app_sizes.dart';

class CustomPngImage extends StatelessWidget {
  const CustomPngImage(
      {Key? key, required this.path, this.height, this.width, this.radius, this.color})
      : super(key: key);

  CustomPngImage.square({Key? key, required String path,double? size})
      : this(
          key: key,
          path: path,
          height: size??AppSizes.pw100,
          width: size??AppSizes.pw100,
          radius: BorderRadius.circular(AppSizes.br8),
        );
  CustomPngImage.circular({Key? key, required String path,double? size})
      : this(
    key: key,
    path: path,
    height: size??AppSizes.pw100,
    width: size??AppSizes.pw100,
    radius: BorderRadius.circular(AppSizes.brMax),
  );

  final String path;
  final double? height;
  final double? width;
  final Color? color;

  final BorderRadiusGeometry? radius;


  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: radius ?? BorderRadius.zero,
      child: Image.asset(
        path,
        height: height,
        width: width,
        fit: BoxFit.fill,color: color,
      ),
    );
  }
}
