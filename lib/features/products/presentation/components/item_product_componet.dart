import 'package:flutter/material.dart';
import 'package:horsehouse/core/global/theme/theme_color/theme_color_light.dart';
import 'package:horsehouse/core/services/number_parser.dart';
import 'package:horsehouse/core/utils/app_fonsts.dart';
import 'package:horsehouse/core/utils/app_sizes.dart';
import 'package:horsehouse/core/widget/images/custom_network_image.dart';
import 'package:horsehouse/core/widget/custom_text.dart';
import 'package:horsehouse/features/products/domain/entities/product_entity.dart';
import 'package:horsehouse/features/products/presentation/controllers/products_provider.dart';
import 'package:horsehouse/features/products/presentation/widgets/cart_widget.dart';
import 'package:horsehouse/features/products/presentation/widgets/favorite_widget.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

class ItemProductComponent extends StatelessWidget {
  final ProductEntity product;

  const ItemProductComponent({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductsProvider>(
      builder: (context, provider, child) {
        int itemCountCart = provider.getMyCartNumber(productId: product.id);

        return Card(
          color: Theme.of(context).cardColor,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSizes.br16)),
          child: Column(
            children: [
              ///image product,favorite,cart
              Stack(
                children: [
                  ///image product
                  Container(
                    width: double.infinity,
                    height: AppSizes.ph180,
                    padding: EdgeInsets.fromLTRB(AppSizes.ph6, AppSizes.ph6, AppSizes.ph6, AppSizes.ph6),
                    child: CustomNetworkImage.circle(
                      imageUrl: product.imageUrl,
                      fit: BoxFit.cover,
                      size: double.infinity,
                    ),
                  ),

                  ///favorite
                  Positioned(
                    right: AppSizes.ph5,
                    top: AppSizes.ph5,
                    child: InkWell(
                        onTap: () {
                          if (provider.myFavoriteProducts.contains(product.id)) {
                            provider.removeProductFromFavorite(productId: product.id);
                          } else {
                            provider.addProductToFavorite(productId: product.id);
                          }
                        },
                        child: FavoriteWidget(isFavorite: provider.myFavoriteProducts.contains(product.id))),
                  ),

                  ///cart
                  Positioned(
                      left: AppSizes.ph5,
                      top: AppSizes.ph5,
                      child: CartWidget(
                        itemCount: itemCountCart,
                      )),
                ],
              ),

              ///price,title,cart item
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ///price,add to cart,subtract from cart
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: AppSizes.pw6),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          /// add to cart
                          IconButton(
                            onPressed: () {
                              provider.addToMyCart(productId: product.id);
                            },
                            constraints: const BoxConstraints(),
                            padding: EdgeInsets.zero,
                            icon: Icon(
                              MdiIcons.plusCircleOutline,
                              color: ThemeColorLight.greenColor,
                              size: AppSizes.ph30,
                            ),
                          ),

                          ///price
                          Container(
                              padding: EdgeInsets.symmetric(horizontal: AppSizes.pw8, vertical: AppSizes.ph5),
                              decoration: BoxDecoration(
                                  color: ThemeColorLight.yellowColor,
                                  borderRadius: BorderRadius.circular(AppSizes.br25)),
                              child: Row(
                                children: [
                                  CustomText.whiteColor(
                                    "\$",
                                    textStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                                          fontWeight: AppFonts.bold,
                                          fontSize: AppSizes.sp18,
                                        ),
                                    maxLines: 3,
                                  ),
                                  CustomText.whiteColor(
                                    product.price.numberParserToArabic(),
                                    textStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                                          fontWeight: AppFonts.bold,
                                          fontSize: AppSizes.sp18,
                                        ),
                                    maxLines: 3,
                                  ),
                                ],
                              )),

                          ///subtract from cart
                          IconButton(
                            onPressed: itemCountCart == 0
                                ? null
                                : () {
                                    provider.removeFromMyCart(productId: product.id);
                                  },
                            icon: Icon(
                              MdiIcons.minusCircleOutline,
                              color: itemCountCart == 0 ? ThemeColorLight.grey : ThemeColorLight.greenColor,
                              size: AppSizes.ph30,
                            ),
                            constraints: const BoxConstraints(),
                            padding: EdgeInsets.zero,
                          )
                        ],
                      ),
                    ),

                    ///description
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: AppSizes.pw12),
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
        );
      },
    );
  }
}
