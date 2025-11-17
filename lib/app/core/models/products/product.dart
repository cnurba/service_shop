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
  final double quantity;
  final bool liked;
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
    this.quantity = 0,
    this.liked = false,
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
      quantity:0,
      liked: false,
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
      liked: json['liked'] ?? false,
      images: (json['images'] as List<dynamic>? ?? [])
          .map((e) => e as String)
          .toList(),
    );
  }

  copyWith({
    String? uuid,
    String? name,
    String? description,
    String? categoryName,
    String? sku,
    String? imageUrl,
    List<String>? images,
    double? price,
    double? count,
    String? propertyUuid,
    String? propertyName,
    String? branchUuid,
    double? quantity,
    bool? liked,
  }) {
    return Product(
      uuid: uuid ?? this.uuid,
      name: name ?? this.name,
      description: description ?? this.description,
      categoryName: categoryName ?? this.categoryName,
      sku: sku ?? this.sku,
      imageUrl: imageUrl ?? this.imageUrl,
      images: images ?? this.images,
      price: price ?? this.price,
      count: count ?? this.count,
      propertyUuid: propertyUuid ?? this.propertyUuid,
      propertyName: propertyName ?? this.propertyName,
      branchUuid: branchUuid ?? this.branchUuid,
      quantity: quantity ?? this.quantity,
      liked: liked ?? this.liked
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
    quantity,
    liked,
  ];
}
