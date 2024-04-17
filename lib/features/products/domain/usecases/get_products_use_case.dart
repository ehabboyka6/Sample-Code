import 'package:dartz/dartz.dart';
import 'package:horsehouse/core/error/failure.dart';
import 'package:horsehouse/core/usecases/usecases.dart';
import 'package:horsehouse/features/products/domain/entities/product_entity.dart';
import 'package:horsehouse/features/products/domain/repositories/base_products_repository.dart';

class GetProductsUseCase extends BaseUseCasesNoParam<List<ProductEntity>> {
  BaseProductsRepository baseProductsRepository;

  GetProductsUseCase({required this.baseProductsRepository});

  @override
  Future<Either<Failure, List<ProductEntity>>> call() async {
    return await baseProductsRepository.getProducts();
  }
}
