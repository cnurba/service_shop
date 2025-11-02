import 'package:equatable/equatable.dart';
/// [Product] - Model class representing a product with various attributes.
class Product extends Equatable {
  final String uuid;
  final String name;
  final String propertyUuid;
  final String propertyName;
  final String branchUuid;
  final String description;
  final String categoryName;
  final String sku;
  final String imageUrl;
  final double price;
  final double count;
  final List<String> images;

  const Product({
    required this.uuid,
    required this.name,
    required this.description,
    required this.categoryName,
    required this.branchUuid,
    required this.sku,
    required this.imageUrl,
    required this.images,
    required this.price,
    required this.count,
    required this.propertyUuid,
    required this.propertyName,
  });

  factory Product.empty() {
    return const Product(
      uuid: '',
      name: '',
      description: '',
      categoryName: '',
      branchUuid: '',
      sku: '',
      imageUrl: '',
      images: [],
      price: 0,
      count: 0,
      propertyUuid: '',
      propertyName: '',
    );
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    final price = (json['price'] ?? 0).toDouble();
    final count = (json['count'] ?? 0).toDouble();

    return Product(
      uuid: json['uuid'] ?? '',
      name: json['name'] ?? '',
      count: count,
      price: price,
      description: json['description'] ?? '',
      categoryName: json['categoryName'] ?? '',
      branchUuid: json['branchUuid'] ?? '',
      sku: json['sku'] ?? '',
      propertyName: json['propertyName'] ?? '',
      propertyUuid: json['propertyUuid'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      images: (json['images'] as List<dynamic>? ?? [])
          .map((e) => e as String)
          .toList(),
    );
  }

  @override
  List<Object?> get props => [
    uuid,
    name,
    description,
    categoryName,
    sku,
    imageUrl,
    images,
    price,
    count,
    propertyUuid,
    propertyName,
    branchUuid,
  ];
}
