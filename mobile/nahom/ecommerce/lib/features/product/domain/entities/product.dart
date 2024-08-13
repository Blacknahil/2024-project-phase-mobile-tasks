import 'package:equatable/equatable.dart';

class ProductEntity extends Equatable {
  final String name;
  final String description;
  final int id;
  final String catagory;
  final String imageUrl;
  final int price;

  const ProductEntity({
    required this.name,
    this.id = -1,
    required this.description,
    required this.catagory,
    required this.price,
    this.imageUrl = '',
  });

  @override
  List<Object?> get props => [
        name,
        id,
        description,
        catagory,
        price,
        imageUrl,
      ];
}
