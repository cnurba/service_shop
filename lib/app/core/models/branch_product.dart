import 'package:equatable/equatable.dart';
import 'package:service_shop/app/core/models/products/product.dart';
import 'package:service_shop/app/core/models/property_attribute.dart';
import 'package:service_shop/app/core/models/all_properties/property_attribute_value.dart';

class BranchProduct extends Equatable {
  final Product product;
  final double price;
  final double count;
  final PropertyAttribute mainProperty;
  final List<PropertyAttribute> notMainProperties;
  final List<PropertyAttributeValue> allProperties;

  const BranchProduct({
    required this.product,
    required this.mainProperty,
    required this.notMainProperties,
    required this.allProperties,
    this.price = 0,
    this.count = 0,
  });

  factory BranchProduct.fromJson(Map<String, dynamic> json) {
    return BranchProduct(
      product: Product.fromJson(json['product'] as Map<String, dynamic>),
      price: (json['price'] ?? 0).toDouble(),
      count: (json['count'] ?? 0).toDouble(),
      mainProperty: PropertyAttribute.fromJson(
        json['mainProperty'] as Map<String, dynamic>,
      ),
      notMainProperties: (json['notMainProperties'] as List<dynamic>? ?? [])
          .map((e) => PropertyAttribute.fromJson(e as Map<String, dynamic>))
          .toList(),
      allProperties: (json['allProperties'] as List<dynamic>? ?? [])
          .map(
            (e) => PropertyAttributeValue.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
    );
  }

  @override
  List<Object?> get props => [
    product,
    mainProperty,
    notMainProperties,
    allProperties,
    price,
    count,
  ];
}
