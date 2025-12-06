import 'package:equatable/equatable.dart';
import 'package:service_shop/app/core/models/attribute/property.dart';
import 'package:service_shop/app/core/models/products/product.dart';

class ProductWithProperties extends Equatable {
  final Product product;
  final List<Property> properties;

  const ProductWithProperties({
    required this.product,
    this.properties = const [],
  });

  factory ProductWithProperties.fromJson(Map<String, dynamic> json) {
    return ProductWithProperties(
      product: Product.fromJson(json['product'] as Map<String, dynamic>),
      properties: (json['properties'] as List<dynamic>? ?? [])
          .map(
            (e) => Property.fromJsonWithoutChildren(e as Map<String, dynamic>),
          )
          .toList(),
    );
  }

  @override
  List<Object?> get props => [product, properties];
}
