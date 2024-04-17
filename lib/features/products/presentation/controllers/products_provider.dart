import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:horsehouse/core/global/localization/app_localization.dart';
import 'package:horsehouse/core/services/dependency_injection_services.dart';
import 'package:horsehouse/core/services/navigation_services.dart';
import 'package:horsehouse/core/services/status_bar_manager.dart';
import 'package:horsehouse/core/utils/app_string.dart';
import 'package:horsehouse/core/utils/user_manger.dart';
import 'package:horsehouse/core/widget/dialog_service.dart';
import 'package:horsehouse/features/authentication/presentation/screens/sign_in_screen.dart';
import 'package:horsehouse/features/products/domain/entities/cart_entity.dart';
import 'package:horsehouse/features/products/domain/entities/product_entity.dart';
import 'package:horsehouse/features/products/domain/usecases/add_product_to_favorite_use_case.dart';
import 'package:horsehouse/features/products/domain/usecases/get_my_cart_use_case.dart';
import 'package:horsehouse/features/products/domain/usecases/get_my_favorite_product_use_case.dart';
import 'package:horsehouse/features/products/domain/usecases/get_products_use_case.dart';
import 'package:horsehouse/features/products/domain/usecases/remove_from_my_cart_use_case.dart';
import 'package:horsehouse/features/products/domain/usecases/remove_product_from_favorite_use_case.dart';
import 'package:horsehouse/features/products/domain/usecases/update_my_cart_use_case.dart';
import 'package:horsehouse/features/products/presentation/screens/product_details_screen.dart';
import 'package:horsehouse/features/products/presentation/screens/search_screen.dart';

class ProductsProvider with ChangeNotifier {
  ///var
  bool isProductLoading = true;
  bool isMyFavoriteProductsLoading = true;
  bool isMyCartLoading = true;
  List<ProductEntity> products = [];
  List<int> myFavoriteProducts = [];
  List<CartEntity> myCart = [];
  String? search;

 bool get isProductsEmpty => !isProductLoading && products.isEmpty;

  ///constructor
  ProductsProvider() {
    init();
  }

  Future<void> init({bool withLoading = true}) async {
    await _getProducts(withLoading: withLoading);
    await _getMyFavoriteProduct(withLoading: withLoading);
    await _getMyCart(withLoading: withLoading);
  }

  Future<void> _getProducts({bool withLoading = true}) async {
    if (withLoading) {
      isProductLoading = true;
      notifyListeners();
    }
    (await sl<GetProductsUseCase>()()).fold((l) async {
      await DialogWidget.showCustomDialog(
        context: Get.context!,
        title: l.message,
        buttonName: tr(AppString.ok),
      );
    }, (r) async {
      products = r;
      if (withLoading) {
        isProductLoading = false;
        notifyListeners();
      }
    });
  }

  Future<void> _getMyFavoriteProduct({bool withLoading = true}) async {
    if (withLoading) {
      isMyFavoriteProductsLoading = true;
      notifyListeners();
    }
    (await sl<GetMyFavoriteProductsUseCase>()()).fold((l) async {
      await DialogWidget.showCustomDialog(
        context: Get.context!,
        title: l.message,
        buttonName: tr(AppString.ok),
      );
    }, (r) async {
      myFavoriteProducts = r;
      if (withLoading) {
        isMyFavoriteProductsLoading = false;
        notifyListeners();
      }
    });
  }

  Future<void> _getMyCart({bool withLoading = true}) async {
    if (withLoading) {
      isMyCartLoading = true;
      notifyListeners();
    }
    (await sl<GetMyCartUseCase>()()).fold((l) async {
      await DialogWidget.showCustomDialog(
        context: Get.context!,
        title: l.message,
        buttonName: tr(AppString.ok),
      );
    }, (r) async {
      myCart = r;
      if (withLoading) {
        isMyCartLoading = false;
        notifyListeners();
      }
    });
  }

  Future<void> filterMyFavoriteProduct() async {
    await init(withLoading: false);
    products = products.where((element) {
      return myFavoriteProducts.contains(element.id);
    }).toList();
    notifyListeners();
  }

  Future<void> filterMyCart() async {
    await init(withLoading: false);
    List<ProductEntity> filteredProducts = [];
    for (var cartElement in myCart) {
      filteredProducts.add(products.firstWhere((productElement) => productElement.id == cartElement.productId));
    }
    products = filteredProducts;
    notifyListeners();
  }

  Future<void> addProductToFavorite({required int productId}) async {
    myFavoriteProducts.add(productId);
    notifyListeners();
    await sl<AddProductToFavoriteUseCase>()(productId);
  }

  Future<void> removeProductFromFavorite({required int productId}) async {
    myFavoriteProducts.remove(productId);
    notifyListeners();
    await sl<RemoveProductFromFavoriteUseCase>()(productId);
  }

  int getMyCartNumber({required int productId}) {
    int index = myCart.indexWhere((element) => element.productId == productId);
    if (index != -1) {
      return myCart[index].itemCount;
    } else {
      return 0;
    }
  }

  Future<void> addToMyCart({required int productId}) async {
    int index = myCart.indexWhere((element) => element.productId == productId);
    if (index != -1) {
      myCart[index] = myCart[index].copyWith(itemCount: (myCart[index].itemCount + 1));
      notifyListeners();
      await sl<UpdateMyCartUseCase>()(
          UpdateMyCartParameters(itemCount: myCart[index].itemCount, productId: productId, updateFieldOnly: true));
    } else {
      myCart.add(CartEntity(itemCount: 1, productId: productId));
      notifyListeners();
      await sl<UpdateMyCartUseCase>()(
          UpdateMyCartParameters(itemCount: 1, productId: productId, updateFieldOnly: false));
    }
  }

  Future<void> removeFromMyCart({required int productId}) async {
    int index = myCart.indexWhere((element) => element.productId == productId);
    int itemCount = myCart[index].itemCount - 1;

    if (itemCount > 0) {
      myCart[index] = myCart[index].copyWith(itemCount: (myCart[index].itemCount - 1));
      notifyListeners();
      await sl<UpdateMyCartUseCase>()(
          UpdateMyCartParameters(itemCount: itemCount, productId: productId, updateFieldOnly: true));
    } else {
      myCart.removeAt(index);
      notifyListeners();
      await sl<RemoveFromMyCartUseCase>()(productId);
    }
  }

  Future<void> navigateToSearchScreen(context) async {
    String? search = await NavigationService.navigateTo(
        navigationMethod: NavigationMethod.push,
        page: () => SearchScreen(
              searchText: this.search,
            ));
    StatusBarManager.setLikeAppBarColor(context: context);
    if (search != null) {
      this.search = search;
      await init(withLoading: false);
      products = products.where((element) {
        return element.description.en.toUpperCase().contains(search.toUpperCase()) ||
            element.description.ar.toUpperCase().contains(search.toUpperCase());
      }).toList();
      notifyListeners();
    }
  }

  void navigateToProductDetails({required ProductEntity product}) {
    NavigationService.navigateTo(
        navigationMethod: NavigationMethod.push,
        page: () => ProductDetailsScreen(
              product: product,
            ));
  }

  Future<void> logOut() async {
    await UserManager.logout();
    NavigationService.offAll(page: () => const SignInScreen());
  }

  Future<void> changeLocalization() async {
    await sl<BaseAppLocalizations>().changeLocale();
    NavigationService.goBack();
  }
}
