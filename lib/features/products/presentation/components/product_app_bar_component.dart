import 'package:flutter/material.dart';
import 'package:horsehouse/core/global/localization/app_localization.dart';
import 'package:horsehouse/core/global/theme/theme_color/theme_color_light.dart';
import 'package:horsehouse/core/utils/app_constants.dart';
import 'package:horsehouse/core/utils/app_fonsts.dart';
import 'package:horsehouse/core/utils/app_sizes.dart';
import 'package:horsehouse/core/utils/app_string.dart';
import 'package:horsehouse/core/widget/custom_appbar.dart';
import 'package:horsehouse/core/widget/custom_text.dart';
import 'package:horsehouse/features/products/presentation/controllers/products_provider.dart';
import 'package:horsehouse/features/products/presentation/widgets/cart_widget.dart';
import 'package:horsehouse/features/products/presentation/widgets/favorite_widget.dart';
import 'package:provider/provider.dart';

class ProductAppBarComponent extends StatelessWidget implements PreferredSizeWidget {
  const ProductAppBarComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductsProvider>(
      builder: (context, provider, child) {
        return CustomAppbar(
          withOutElevation: true,
          canPop: false,
          withOutContent: true,
          actions: [
            SizedBox(
              width: AppSizes.pw16,
            ),
            ///search
            IconButton(
              onPressed: () async{
                await provider.navigateToSearchScreen(context);
              },
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              icon: Icon(
                Icons.search_outlined,
                color: ThemeColorLight.yellowColor,
                size: AppSizes.ph30,
              ),
            ),

            SizedBox(
              width: AppSizes.pw16,
            ),

            ///title
            Expanded(
              child: RichText(
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

            ///cart
            InkWell(
              onTap: () {
                provider.filterMyCart();
              },
              child: CartWidget(
                itemCount: provider.myCart.length,
                isLabelVisible: true,
                iconSize: AppSizes.ph30,
              ),
            ),
            SizedBox(
              width: AppSizes.pw16,
            ),

            ///favorite
            InkWell(
              onTap: () {
                provider.filterMyFavoriteProduct();
              },
              child: FavoriteWidget(
                  iconSize: AppSizes.ph30,
                  isFavorite: true,
                  isLabelVisible: true,
                  itemCount: provider.myFavoriteProducts.length),
            ),
            SizedBox(
              width: AppSizes.pw16,
            ),

            ///menu
            Padding(
              padding: EdgeInsetsDirectional.only(end: AppSizes.pw16),
              child: PopupMenuButton<int>(
                elevation: 0,
                color: Theme.of(context).cardColor,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSizes.br13)),
                constraints: BoxConstraints(
                  maxWidth: AppSizes.widthFullScreen * (7 / 10),
                ),
                splashRadius: AppSizes.br13,
                padding: EdgeInsets.zero,
                child: Icon(
                  Icons.menu,
                  size: AppSizes.ph30,
                  color: ThemeColorLight.yellowColor,
                ),
                onSelected: (item) async {
                  switch (item) {
                    case 0:
                      provider.init();
                      break;
                    case 1:
                      provider.changeLocalization();
                      break;
                    default:
                      provider.logOut();
                  }
                },
                itemBuilder: (context) => [
                  PopupMenuItem<int>(
                    value: 0,
                    child: CustomText.greenColor(
                      tr(AppString.showAll),
                      textStyle: Theme.of(context)
                          .textTheme
                          .displayLarge!
                          .copyWith(fontSize: AppSizes.sp18, fontWeight: AppFonts.medium),
                    ),
                  ),
                  PopupMenuItem<int>(
                    value: 1,
                    child: CustomText.greenColor(
                      tr(AppString.changeLocalization),
                      textStyle: Theme.of(context)
                          .textTheme
                          .displayLarge!
                          .copyWith(fontSize: AppSizes.sp18, fontWeight: AppFonts.medium),
                    ),
                  ),
                  PopupMenuItem<int>(
                    value: 2,
                    child: CustomText.greenColor(
                      tr(AppString.logOut),
                      textStyle: Theme.of(context)
                          .textTheme
                          .displayLarge!
                          .copyWith(fontSize: AppSizes.sp18, fontWeight: AppFonts.medium),
                    ),
                  ),
                ],
              ),
            )
          ],
        );
      },
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(AppSizes.ph64);
}
