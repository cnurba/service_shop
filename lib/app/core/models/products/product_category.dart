import 'package:equatable/equatable.dart';
import 'package:service_shop/app/core/models/products/product.dart';

class ProductCategory extends Equatable {
  final String category;
  final List<Product> products;

  const ProductCategory({required this.category, required this.products});

  factory ProductCategory.fromJson(Map<String, dynamic> json) {
    return ProductCategory(
      category: json['category'] ?? '',
      products: (json['products'] as List<dynamic>? ?? [])
          .map((e) => Product.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  ProductCategory copyWith({String? category, List<Product>? products}) {
    return ProductCategory(
      category: category ?? this.category,
      products: products ?? this.products,
    );
  }

  @override
  List<Object?> get props => [category, products];
}
