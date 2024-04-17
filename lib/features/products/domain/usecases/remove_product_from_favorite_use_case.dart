import 'package:dartz/dartz.dart';
import 'package:horsehouse/core/error/failure.dart';
import 'package:horsehouse/core/usecases/usecases.dart';
import 'package:horsehouse/features/products/domain/repositories/base_products_repository.dart';

class RemoveProductFromFavoriteUseCase extends BaseUseCases<void, int> {
  BaseProductsRepository baseProductsRepository;

  RemoveProductFromFavoriteUseCase({required this.baseProductsRepository});

  @override
  Future<Either<Failure, void>> call(int parameters) async {
    return await baseProductsRepository.removeProductFromFavorite(productId: parameters);
  }
}
