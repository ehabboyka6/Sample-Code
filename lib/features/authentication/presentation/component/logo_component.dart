import 'package:flutter/material.dart';
import 'package:horsehouse/core/global/localization/app_localization.dart';
import 'package:horsehouse/core/utils/app_assets.dart';
import 'package:horsehouse/core/utils/app_fonsts.dart';
import 'package:horsehouse/core/utils/app_sizes.dart';
import 'package:horsehouse/core/utils/app_string.dart';
import 'package:horsehouse/core/widget/custom_text.dart';

class LogoComponent extends StatelessWidget {
  const LogoComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.fromLTRB(AppSizes.pw15, AppSizes.ph80, AppSizes.zero, AppSizes.zero),
          child: CustomText(tr(AppString.hello),
              textStyle:
                  Theme.of(context).textTheme.titleSmall!.copyWith(fontSize: AppSizes.sp80, fontWeight: AppFonts.bold)),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(AppSizes.pw200, AppSizes.ph90, AppSizes.zero, AppSizes.zero),
          child: Image.asset(
            AppAssets.cartPng,
            width: AppSizes.ph150,
            height: AppSizes.ph150,
          ),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(AppSizes.pw16, AppSizes.ph145, AppSizes.zero, AppSizes.zero),
          child: CustomText(tr(AppString.there),
              textStyle:
                  Theme.of(context).textTheme.titleSmall!.copyWith(fontSize: AppSizes.sp80, fontWeight: AppFonts.bold)),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(AppSizes.pw220, AppSizes.ph145, AppSizes.zero, AppSizes.zero),
          child: CustomText('.',
              textStyle: Theme.of(context)
                  .textTheme
                  .displayMedium!
                  .copyWith(fontSize: AppSizes.sp80, fontWeight: AppFonts.bold)),
        )
      ],
    );
  }
}
