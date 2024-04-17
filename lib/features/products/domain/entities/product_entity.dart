import 'package:equatable/equatable.dart';
import 'package:horsehouse/core/models/name.dart';

class ProductEntity extends Equatable {
  final int id;
  final int price;
  final String imageUrl;
  final Name description;

  const ProductEntity({
    required this.id,
    required this.price,
    required this.imageUrl,
    required this.description,
  });

  @override
  List<Object?> get props => [
        id,
        price,
        imageUrl,
        description,
      ];
}
