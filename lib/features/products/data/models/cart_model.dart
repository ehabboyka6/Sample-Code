import 'package:horsehouse/features/products/domain/entities/cart_entity.dart';

class CartModel extends CartEntity {
  const CartModel({
    required super.productId,
    required super.itemCount,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      productId: json['productId'],
      itemCount: json['itemCount'],
    );
  }
}
