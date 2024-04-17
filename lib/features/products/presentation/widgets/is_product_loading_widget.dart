import 'package:flutter/material.dart';
import 'package:horsehouse/core/global/theme/theme_color/theme_color_light.dart';
import 'package:horsehouse/core/utils/app_sizes.dart';
import 'package:horsehouse/core/widget/custom_loading_shimmer.dart';

class IsProductLoadingWidget extends StatelessWidget {
  const IsProductLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(AppSizes.ph6),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSizes.br16), border: Border.all(color: ThemeColorLight.grey)),
      child: CustomLoadingShimmer(
        color: ThemeColorLight.greenColor.withOpacity(0.1),
        width: double.infinity,
        height: double.infinity,
        borderRadius: BorderRadius.circular(AppSizes.br16),
      ),
    );
  }
}
