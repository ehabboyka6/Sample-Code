import 'package:dartz/dartz.dart';
import 'package:horsehouse/core/error/failure.dart';
import 'package:horsehouse/features/products/domain/entities/cart_entity.dart';
import 'package:horsehouse/features/products/domain/entities/product_entity.dart';
import 'package:horsehouse/features/products/domain/usecases/update_my_cart_use_case.dart';

abstract class BaseProductsRepository {
  Future<Either<Failure, List<ProductEntity>>> getProducts();
  Future<Either<Failure, List<int>>> getMyFavoriteProducts();
  Future<Either<Failure, List<CartEntity>>> getMyCart();
  Future<Either<Failure, void>> addProductToFavorite({required int productId});
  Future<Either<Failure, void>> removeProductFromFavorite({required int productId});
  Future<Either<Failure, void>> updateMyCart({required UpdateMyCartParameters updateMyCartParameters});
  Future<Either<Failure, void>> removeFromMyCart({required int productId});
}
