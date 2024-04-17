import 'package:dartz/dartz.dart';
import 'package:horsehouse/core/error/failure.dart';
import 'package:horsehouse/core/usecases/usecases.dart';
import 'package:horsehouse/features/products/domain/entities/cart_entity.dart';
import 'package:horsehouse/features/products/domain/repositories/base_products_repository.dart';

class GetMyCartUseCase extends BaseUseCasesNoParam<List<CartEntity>> {
  BaseProductsRepository baseProductsRepository;

  GetMyCartUseCase({required this.baseProductsRepository});

  @override
  Future<Either<Failure, List<CartEntity>>> call() async {
    return await baseProductsRepository.getMyCart();
  }
}
