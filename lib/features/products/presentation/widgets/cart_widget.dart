import 'package:flutter/material.dart';
import 'package:horsehouse/core/global/theme/theme_color/theme_color_light.dart';
import 'package:horsehouse/core/services/number_parser.dart';
import 'package:horsehouse/core/utils/app_fonsts.dart';
import 'package:horsehouse/core/utils/app_sizes.dart';
import 'package:horsehouse/core/widget/custom_text.dart';

class CartWidget extends StatelessWidget {
 final int itemCount;
 final double? iconSize;
 final bool isLabelVisible;
  const CartWidget({super.key,this.itemCount=0,this.iconSize,this.isLabelVisible=true});

  @override
  Widget build(BuildContext context) {
    return  Badge(
      backgroundColor: Colors.green,
      isLabelVisible:isLabelVisible,
      label: CustomText.whiteColor(
        itemCount.toString().numberParserToArabic(),
        textStyle: Theme.of(context).textTheme.bodySmall!.copyWith(fontWeight: AppFonts.bold,fontSize: AppSizes.sp10),
        textAlign: TextAlign.center,
      ),
      child:  Icon(
        Icons.shopping_cart,
        color: ThemeColorLight.yellowColor,
        size: iconSize??AppSizes.ph25,
      ),
    );
  }
}
