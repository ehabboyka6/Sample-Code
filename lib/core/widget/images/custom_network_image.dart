import 'package:flutter/material.dart';

import '../../utils/app_sizes.dart';
import 'custom_cashed_network_image.dart';

class CustomNetworkImage extends StatelessWidget {
  const CustomNetworkImage({
    Key? key,
    required this.imageUrl,
    this.errorImageUrl,
    this.height,
    this.width,
    this.fit,
    this.radius,
  }) : super(key: key);

  CustomNetworkImage.circle(
      {Key? key, required String imageUrl, String? errorImageUrl, required double size, BoxFit? fit})
      : this(
            key: key,
            radius: BorderRadius.circular(AppSizes.brMax),
            imageUrl: imageUrl,
            errorImageUrl: errorImageUrl,
            height: size,
            width: size,
            fit: fit);

  CustomNetworkImage.square(
      {Key? key, required String imageUrl, String? errorImageUrl, required double size, BorderRadius? radius})
      : this(
          key: key,
          radius: radius ?? BorderRadius.circular(AppSizes.br8),
          imageUrl: imageUrl,
          errorImageUrl: errorImageUrl,
          height: size,
          width: size,
        );

  CustomNetworkImage.rectangle(
      {Key? key,
      required String imageUrl,
      String? errorImageUrl,
      required double height,
      required double width,
      BoxFit? fit,
      BorderRadius? radius})
      : this(
            key: key,
            radius: radius ?? BorderRadius.circular(AppSizes.br8),
            imageUrl: imageUrl,
            errorImageUrl: errorImageUrl,
            height: height,
            width: width,
            fit: fit);

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
      child: CustomCashedNetworkImage(
        imageUrl: imageUrl,
        width: width,
        height: height,
        fit: fit ?? BoxFit.cover,
        errorImageUrl: errorImageUrl,
        radius: BorderRadius.zero,
      ),
    );
  }
}
