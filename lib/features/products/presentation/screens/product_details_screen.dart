import 'package:flutter/material.dart';
import 'package:horsehouse/core/global/theme/theme_color/theme_color_light.dart';
import 'package:horsehouse/core/services/number_parser.dart';
import 'package:horsehouse/core/utils/app_fonsts.dart';
import 'package:horsehouse/core/utils/app_sizes.dart';
import 'package:horsehouse/core/widget/custom_text.dart';
import 'package:horsehouse/core/widget/images/custom_avatar_image.dart';
import 'package:horsehouse/features/products/domain/entities/product_entity.dart';
import 'package:horsehouse/features/products/presentation/components/product_details_app_bar_component.dart';
import 'package:horsehouse/features/products/presentation/widgets/cart_widget.dart';
import 'package:horsehouse/features/products/presentation/widgets/favorite_widget.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ProductDetailsScreen extends StatelessWidget {
  final ProductEntity product;

  const ProductDetailsScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ProductDetailsAppBarComponent(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppSizes.pw32),
        child: Column(
          children: [
            SizedBox(
              height: AppSizes.ph32,
            ),

            ///image product,favorite,cart
            Stack(
              children: [
                ///image product
                CustomAvatarImage(product.imageUrl, radius: AppSizes.br180),

                ///favorite
                Positioned(
                  right: AppSizes.ph5,
                  top: AppSizes.ph5,
                  child: FavoriteWidget(iconSize: AppSizes.ph40),
                ),

                ///cart
                Positioned(
                    left: AppSizes.ph5,
                    top: AppSizes.ph5,
                    child: CartWidget(itemCount: 10, iconSize: AppSizes.ph40)),
              ],
            ),
            SizedBox(
              height: AppSizes.ph32,
            ),

            ///price,title,cart item
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ///price,add to cart,subtract from cart
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: AppSizes.pw12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        /// add to cart
                        Icon(
                          MdiIcons.plusCircleOutline,
                          color: ThemeColorLight.greenColor,
                          size: AppSizes.ph40,
                        ),

                        ///price
                        Container(
                            padding: EdgeInsets.symmetric(horizontal: AppSizes.pw16, vertical: AppSizes.ph5),
                            decoration: BoxDecoration(
                                color: ThemeColorLight.yellowColor, borderRadius: BorderRadius.circular(AppSizes.br25)),
                            child: Row(
                              children: [
                                CustomText.whiteColor(
                                  "\$ ",
                                  textStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                                    fontWeight: AppFonts.bold,
                                    fontSize: AppSizes.sp24,
                                  ),
                                  maxLines: 3,
                                ),
                                CustomText.whiteColor(
                                  product.price.numberParserToArabic(),
                                  textStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                                        fontWeight: AppFonts.bold,
                                        fontSize: AppSizes.sp24,
                                      ),
                                  maxLines: 3,
                                ),
                              ],
                            )),

                        ///subtract from cart
                        Icon(
                          MdiIcons.minusCircleOutline,
                          color: ThemeColorLight.greenColor,
                          size: AppSizes.ph40,
                        )
                      ],
                    ),
                  ),

                  ///description
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: AppSizes.ph32, horizontal: AppSizes.pw12),
                    child: CustomText.greyColor(
                      product.description.localizedName,
                      textAlign: TextAlign.center,
                      textStyle: Theme.of(context).textTheme.displaySmall!.copyWith(
                            fontWeight: AppFonts.semiBold,
                            fontSize: AppSizes.sp16,
                          ),
                      maxLines: 3,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
