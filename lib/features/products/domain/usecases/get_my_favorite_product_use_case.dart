import 'package:dartz/dartz.dart';
import 'package:horsehouse/core/error/failure.dart';
import 'package:horsehouse/core/usecases/usecases.dart';
import 'package:horsehouse/features/products/domain/repositories/base_products_repository.dart';

class GetMyFavoriteProductsUseCase extends BaseUseCasesNoParam<List<int>> {
  BaseProductsRepository baseProductsRepository;

  GetMyFavoriteProductsUseCase({required this.baseProductsRepository});

  @override
  Future<Either<Failure, List<int>>> call() async {
    return await baseProductsRepository.getMyFavoriteProducts();
  }
}
