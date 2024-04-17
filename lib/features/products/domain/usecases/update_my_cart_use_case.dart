import 'package:equatable/equatable.dart';

import 'package:dartz/dartz.dart';
import 'package:horsehouse/core/error/failure.dart';
import 'package:horsehouse/core/usecases/usecases.dart';
import 'package:horsehouse/features/products/domain/repositories/base_products_repository.dart';

class UpdateMyCartUseCase extends BaseUseCases<void, UpdateMyCartParameters> {
  BaseProductsRepository baseProductsRepository;

  UpdateMyCartUseCase({required this.baseProductsRepository});

  @override
  Future<Either<Failure, void>> call(UpdateMyCartParameters parameters) async {
    return await baseProductsRepository.updateMyCart(updateMyCartParameters: parameters);
  }
}


class UpdateMyCartParameters extends Equatable {
  final int itemCount;
  final int productId;
  final bool updateFieldOnly;

  const UpdateMyCartParameters({
    required this.itemCount,
    required this.productId,
    required this.updateFieldOnly,
  });

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'itemCount': itemCount,
    };
  }

  @override
  List<Object?> get props => [
        itemCount,
        productId,
      ];
}
