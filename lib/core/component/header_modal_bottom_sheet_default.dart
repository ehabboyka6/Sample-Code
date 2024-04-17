import 'package:flutter/material.dart';

import '../services/navigation_services.dart';
import '../utils/app_assets.dart';
import '../utils/app_sizes.dart';
import '../widget/images/custom_svg_image.dart';

class HeaderModalBottomSheetDefault extends StatelessWidget {
  const HeaderModalBottomSheetDefault({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(AppSizes.pw16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              onPressed: () {
                NavigationService.goBack();
              },
              icon: CustomSvgImage(
                path: AppAssets.closeSquareSvg,
                width: AppSizes.ph25,
                height: AppSizes.ph25,
                color: Theme.of(context).iconTheme.color,
              )),
          SizedBox(
            width: AppSizes.pw66,
            child: Divider(
              thickness: AppSizes.ph3,
              color: Theme.of(context).iconTheme.color,
            ),
          ),
          SizedBox(
            width: AppSizes.ph25,
          ),
        ],
      ),
    );
  }
}
