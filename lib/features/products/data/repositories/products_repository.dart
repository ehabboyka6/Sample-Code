import 'package:dartz/dartz.dart';
import 'package:horsehouse/core/error/failure.dart';
import 'package:horsehouse/features/products/data/datasource/products_datasource.dart';
import 'package:horsehouse/features/products/domain/entities/cart_entity.dart';
import 'package:horsehouse/features/products/domain/entities/product_entity.dart';
import 'package:horsehouse/features/products/domain/repositories/base_products_repository.dart';
import 'package:horsehouse/features/products/domain/usecases/update_my_cart_use_case.dart';

class ProductsRepository extends BaseProductsRepository {
  final BaseProductsDatasource baseProductsDatasource;

  ProductsRepository(this.baseProductsDatasource);

  @override
  Future<Either<Failure, List<ProductEntity>>> getProducts() async {
    try {
      return Right(await baseProductsDatasource.getProducts());
    } on FailureException catch (ex, s) {
      return Left(FirebaseFailure(code: ex.code, message: ex.message));
    }
  }

  @override
  Future<Either<Failure, List<int>>> getMyFavoriteProducts() async {
    try {
      return Right(await baseProductsDatasource.getMyFavoriteProducts());
    } on FailureException catch (ex, s) {
      return Left(FirebaseFailure(code: ex.code, message: ex.message));
    }
  }

  @override
  Future<Either<Failure, void>> addProductToFavorite({required int productId}) async {
    try {
      return Right(await baseProductsDatasource.addProductToFavorite(productId: productId));
    } on FailureException catch (ex, s) {
      return Left(FirebaseFailure(code: ex.code, message: ex.message));
    }
  }

  @override
  Future<Either<Failure, void>> removeProductFromFavorite({required int productId}) async {
    try {
      return Right(await baseProductsDatasource.removeProductFromFavorite(productId: productId));
    } on FailureException catch (ex, s) {
      return Left(FirebaseFailure(code: ex.code, message: ex.message));
    }
  }

  @override
  Future<Either<Failure, List<CartEntity>>> getMyCart() async{
    try {
      return Right(await baseProductsDatasource.getMyCart());
    } on FailureException catch (ex, s) {
      return Left(FirebaseFailure(code: ex.code, message: ex.message));
    }
  }

  @override
  Future<Either<Failure, void>> removeFromMyCart({required int productId})async {
    try {
      return Right(await baseProductsDatasource.removeFromMyCart(productId: productId));
    } on FailureException catch (ex, s) {
    return Left(FirebaseFailure(code: ex.code, message: ex.message));
    }
  }

  @override
  Future<Either<Failure, void>> updateMyCart({required UpdateMyCartParameters updateMyCartParameters})async {
    try {
      return Right(await baseProductsDatasource.updateMyCart(updateMyCartParameters: updateMyCartParameters));
    } on FailureException catch (ex, s) {
    return Left(FirebaseFailure(code: ex.code, message: ex.message));
    }
  }
}
