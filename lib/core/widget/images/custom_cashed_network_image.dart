import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../utils/app_sizes.dart';

class CustomCashedNetworkImage extends StatelessWidget {
  const CustomCashedNetworkImage({
    Key? key,
    required this.imageUrl,
    this.errorImageUrl,
    this.height,
    this.width,
    this.fit,
    this.radius,
  }) : super(key: key);

  CustomCashedNetworkImage.circle({
    Key? key,
    required String imageUrl,
    String? errorImageUrl,
    required double size,
  }) : this(
          key: key,
          radius: BorderRadius.circular(AppSizes.brMax),
          imageUrl: imageUrl,
          errorImageUrl: errorImageUrl,
          height: size,
          width: size,
        );

  CustomCashedNetworkImage.square(
      {Key? key, required String imageUrl, String? errorImageUrl, required double size, BorderRadius? radius})
      : this(
          key: key,
          radius: radius ?? BorderRadius.circular(AppSizes.br8),
          imageUrl: imageUrl,
          errorImageUrl: errorImageUrl,
          height: size,
          width: size,
        );

  CustomCashedNetworkImage.rectangle(
      {Key? key,
      required String imageUrl,
      String? errorImageUrl,
      required double height,
      required double width,
      BorderRadius? radius})
      : this(
          key: key,
          radius: radius ?? BorderRadius.circular(AppSizes.br8),
          imageUrl: imageUrl,
          errorImageUrl: errorImageUrl,
          height: height,
          width: width,
        );

  final String imageUrl;
  final String? errorImageUrl;
  final double? height;
  final double? width;
  final BoxFit? fit;
  final BorderRadius? radius;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: radius ?? BorderRadius.circular(AppSizes.br8),
      child: CachedNetworkImage(
        height: height ?? AppSizes.ph200,
        width: width ?? AppSizes.widthFullScreen,
        fit: fit ?? BoxFit.cover,
        imageUrl: imageUrl,
      ),
    );
  }
}
