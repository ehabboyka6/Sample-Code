import 'package:flutter/material.dart';

import '../../utils/app_sizes.dart';

class CustomAvatarImage extends StatefulWidget {
  const CustomAvatarImage(
    this.url, {
    Key? key,
    this.errorImageUrl,
    this.radius,
  }) : super(key: key);
  final double? radius;
  final String url;
  final String? errorImageUrl;

  @override
  State<CustomAvatarImage> createState() => _CustomAvatarImageState();
}

class _CustomAvatarImageState extends State<CustomAvatarImage> {
  bool isErrorImage = false;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: widget.radius ?? AppSizes.br25,
      backgroundImage: isErrorImage && widget.errorImageUrl != null
          ? NetworkImage(widget.errorImageUrl!)
          : NetworkImage(
              widget.url,
            ),
      onBackgroundImageError: (_, __) {
        setState(() {
          isErrorImage = true;
        });
      },
    );
  }
}
