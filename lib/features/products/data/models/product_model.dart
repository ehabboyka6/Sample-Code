import 'package:horsehouse/core/models/name.dart';
import 'package:horsehouse/features/products/domain/entities/product_entity.dart';

class ProductModel extends ProductEntity {
  const ProductModel({
    required super.id,
    required super.description,
    required super.imageUrl,
    required super.price,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      description: Name.fromMap(json['decription']),
      imageUrl: json['imageUrl'],
      price: json['price'],
    );
  }
}
