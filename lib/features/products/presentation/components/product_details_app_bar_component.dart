import 'package:flutter/material.dart';
import 'package:horsehouse/core/utils/app_constants.dart';
import 'package:horsehouse/core/utils/app_fonsts.dart';
import 'package:horsehouse/core/utils/app_sizes.dart';
import 'package:horsehouse/core/widget/custom_appbar.dart';

class ProductDetailsAppBarComponent extends StatelessWidget implements PreferredSizeWidget {
  const ProductDetailsAppBarComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomAppbar(
      withOutElevation: true,
      canPop: false,
      withOutContent: true,
      actions: [

        const CustomBackButton(),

        SizedBox(
          width: AppSizes.pw16,
        ),

        ///title
        Expanded(
          child: RichText(
              textAlign: TextAlign.start,
              text: TextSpan(children: [
                TextSpan(
                    text: AppConstance.appName.substring(0, AppConstance.appName.length - 1),
                    style: Theme.of(context)
                        .textTheme
                        .displayLarge!
                        .copyWith(fontSize: AppSizes.sp24, fontWeight: AppFonts.semiBold)),
                TextSpan(
                  text: AppConstance.appName.substring(AppConstance.appName.length - 1, AppConstance.appName.length),
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall!
                      .copyWith(fontSize: AppSizes.sp24, fontWeight: AppFonts.semiBold),
                ),
              ])),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(AppSizes.ph64);
}
