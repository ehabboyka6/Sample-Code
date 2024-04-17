import 'package:flutter/material.dart';
import 'package:horsehouse/core/services/number_parser.dart';
import 'package:horsehouse/core/utils/app_fonsts.dart';
import 'package:horsehouse/core/utils/app_sizes.dart';
import 'package:horsehouse/core/widget/custom_text.dart';

class FavoriteWidget extends StatelessWidget {
  final bool isFavorite;
  final bool isLabelVisible;
  final double? iconSize;
  final int itemCount;

  const FavoriteWidget({super.key,this.isFavorite=false,this.iconSize,this.isLabelVisible=false,this.itemCount=0});

  @override
  Widget build(BuildContext context) {
    return Badge(
      backgroundColor: Colors.green,
      isLabelVisible:isFavorite&&isLabelVisible,
      label: CustomText.whiteColor(
        itemCount.toString().numberParserToArabic(),
        textStyle: Theme.of(context).textTheme.bodySmall!.copyWith(fontWeight: AppFonts.bold,fontSize: AppSizes.sp10),
        textAlign: TextAlign.center,
      ),
      child: Icon(
        isFavorite ? Icons.favorite : Icons.favorite_border,
        color: Colors.amber,
        size: iconSize??AppSizes.ph25,
      ),
    );
  }
}
