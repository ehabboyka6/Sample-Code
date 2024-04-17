import 'package:equatable/equatable.dart';

class CartEntity extends Equatable {
  final int productId;
  final int itemCount;

  const CartEntity({
    required this.productId,
    required this.itemCount,
  });

  CartEntity copyWith({int? itemCount}) {
    return CartEntity(itemCount: itemCount ?? this.itemCount, productId: productId);
  }

  @override
  List<Object?> get props => [
        productId,
        itemCount,
      ];
}
