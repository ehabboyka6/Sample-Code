import 'package:flutter/material.dart';
import 'package:horsehouse/core/global/localization/app_localization.dart';
import 'package:horsehouse/core/global/theme/theme_color/theme_color_light.dart';
import 'package:horsehouse/core/services/status_bar_manager.dart';
import 'package:horsehouse/core/utils/app_constants.dart';
import 'package:horsehouse/core/utils/app_fonsts.dart';
import 'package:horsehouse/core/utils/app_sizes.dart';
import 'package:horsehouse/core/utils/app_string.dart';
import 'package:horsehouse/core/widget/custom_text.dart';
import 'package:horsehouse/features/products/presentation/components/item_product_componet.dart';
import 'package:horsehouse/features/products/presentation/components/product_app_bar_component.dart';
import 'package:horsehouse/features/products/presentation/controllers/products_provider.dart';
import 'package:horsehouse/features/products/presentation/widgets/is_product_loading_widget.dart';
import 'package:provider/provider.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    StatusBarManager.setLikeAppBarColor(context: context);
    return ChangeNotifierProvider(
      create: (BuildContext context) => ProductsProvider(),
      child: Consumer<ProductsProvider>(
        builder: (context, provider, child) {
          return Scaffold(
            backgroundColor: Theme.of(context).backgroundColor,
            appBar: const ProductAppBarComponent(),
            body: RefreshIndicator(
              color: ThemeColorLight.greenColor,
              onRefresh: () async {
                provider.init();
              },
              child: Builder(builder: (context) {
                if (provider.isProductsEmpty) {
                  return Center(
                    child: CustomText.greyColor(
                      tr(AppString.noResultFound),
                      textStyle: Theme.of(context).textTheme.displaySmall!.copyWith(
                            fontWeight: AppFonts.semiBold,
                            fontSize: AppSizes.sp24,
                          ),
                    ),
                  );
                } else {
                  return GridView.builder(
                    padding: EdgeInsets.only(top: AppSizes.ph6, right: AppSizes.pw6, left: AppSizes.pw6),
                    itemCount: provider.isProductLoading ? AppConstance.defaultItemCountSizeForShimmer : provider.products.length,
                    itemBuilder: (ctx, index) {
                      if (provider.isProductLoading) {
                        return const IsProductLoadingWidget();
                      } else {
                        return InkWell(
                          onTap: () {
                            provider.navigateToProductDetails(product: provider.products[index]);
                          },
                          child: ItemProductComponent(
                            product: provider.products[index],
                          ),
                        );
                      }
                    },
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 0,
                      mainAxisSpacing: 0,
                      childAspectRatio: 0.65,
                    ),
                  );
                }
              }),
            ),
          );
        },
      ),
    );
  }
}
