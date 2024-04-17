import 'package:horsehouse/core/network/firestore_caller.dart';
import 'package:horsehouse/core/network/firestore_path.dart';
import 'package:horsehouse/core/services/dependency_injection_services.dart';
import 'package:horsehouse/core/utils/user_manger.dart';
import 'package:horsehouse/features/products/data/models/cart_model.dart';
import 'package:horsehouse/features/products/data/models/product_model.dart';
import 'package:horsehouse/features/products/domain/entities/cart_entity.dart';
import 'package:horsehouse/features/products/domain/entities/product_entity.dart';
import 'package:horsehouse/features/products/domain/usecases/update_my_cart_use_case.dart';

abstract class BaseProductsDatasource {
  Future<List<ProductEntity>> getProducts();

  Future<List<int>> getMyFavoriteProducts();

  Future<List<CartEntity>> getMyCart();

  Future<void> addProductToFavorite({required int productId});

  Future<void> removeProductFromFavorite({required int productId});

  Future<void> updateMyCart({required UpdateMyCartParameters updateMyCartParameters});

  Future<void> removeFromMyCart({required int productId});
}

class ProductsDatasource implements BaseProductsDatasource {
  @override
  Future<List<ProductEntity>> getProducts() async {
    return await sl<FireStoreCaller>().getCollection(
      path: FireStorePath.productCollectionPath,
      builder: (data) {
        return List<ProductEntity>.from(data.map((e) => ProductModel.fromJson(e.data() as Map<String, dynamic>)));
      },
    );
  }

  @override
  Future<List<int>> getMyFavoriteProducts() async {
    return await sl<FireStoreCaller>().getCollection(
      path:
          '${FireStorePath.userCollectionPath}/${UserManager.authenticationEntity!.email}/${FireStorePath.myFavoriteProductCollectionPath}',
      builder: (data) {
        return List<int>.from(data.map((e) => e['productId']));
      },
    );
  }

  @override
  Future<void> addProductToFavorite({required int productId}) async {
    return await sl<FireStoreCaller>().setDocument(
        path:
            '${FireStorePath.userCollectionPath}/${UserManager.authenticationEntity!.email}/${FireStorePath.myFavoriteProductCollectionPath}',
        docId: productId.toString(),
        data: {'productId': productId});
  }

  @override
  Future<void> removeProductFromFavorite({required int productId}) async {
    return await sl<FireStoreCaller>().deleteDocument(
      path:
          '${FireStorePath.userCollectionPath}/${UserManager.authenticationEntity!.email}/${FireStorePath.myFavoriteProductCollectionPath}/${productId.toString()}',
    );
  }

  @override
  Future<List<CartEntity>> getMyCart() async {
    return await sl<FireStoreCaller>().getCollection(
      path:
          '${FireStorePath.userCollectionPath}/${UserManager.authenticationEntity!.email}/${FireStorePath.myCartCollectionPath}',
      builder: (data) {
        return List<CartEntity>.from(data.map((e) => CartModel.fromJson(e.data() as Map<String, dynamic>)));
      },
    );
  }

  @override
  Future<void> removeFromMyCart({required int productId}) async {
    return await sl<FireStoreCaller>().deleteDocument(
      path:
          '${FireStorePath.userCollectionPath}/${UserManager.authenticationEntity!.email}/${FireStorePath.myCartCollectionPath}/${productId.toString()}',
    );
  }

  @override
  Future<void> updateMyCart({required UpdateMyCartParameters updateMyCartParameters}) async {
    if (updateMyCartParameters.updateFieldOnly) {
      return await sl<FireStoreCaller>().updateDocument(
        path:
            '${FireStorePath.userCollectionPath}/${UserManager.authenticationEntity!.email}/${FireStorePath.myCartCollectionPath}/${updateMyCartParameters.productId.toString()}',
        data: updateMyCartParameters.toMap(),
      );
    } else {
      return await sl<FireStoreCaller>().setDocument(
          path:
              '${FireStorePath.userCollectionPath}/${UserManager.authenticationEntity!.email}/${FireStorePath.myCartCollectionPath}',
          data: updateMyCartParameters.toMap(),
          docId: updateMyCartParameters.productId.toString());
    }
  }
}
