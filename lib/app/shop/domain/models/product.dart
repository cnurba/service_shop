import 'package:equatable/equatable.dart';

class ShopProductCategory extends Equatable {
  final String category;
  final List<ShopProduct> products;

  const ShopProductCategory({required this.category, required this.products});

  factory ShopProductCategory.fromJson(Map<String, dynamic> json) {
    return ShopProductCategory(
      category: json['category'] ?? '',
      products: (json['products'] as List<dynamic>? ?? [])
          .map((e) => ShopProduct.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'category': category,
    'products': products.map((e) => e.toJson()).toList(),
  };

  @override
  List<Object?> get props => [category, products];
}

class ShopProductProperty extends Equatable {
  final String propertyValue;
  final double price;
  final double count;

  const ShopProductProperty({
    required this.propertyValue,
    required this.price,
    required this.count,
  });

  factory ShopProductProperty.fromJson(Map<String, dynamic> json) {
    final price = (json['price'] ?? 0).toDouble();
    final count = (json['count'] ?? 0).toDouble();

    return ShopProductProperty(
      propertyValue: json['propertyValue'] ?? '',
      price: price ?? 0.0,
      count: count ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() => {
    'propertyValue': propertyValue,
    'price': price,
    'count': count,
  };

  @override
  List<Object?> get props => [propertyValue, price, count];
}

class ShopProductAttribute extends Equatable {
  final String attributeName;
  final String attributeUuid;
  final List<ShopProductProperty> properties;

  const ShopProductAttribute({
    required this.attributeName,
    required this.attributeUuid,
    required this.properties,
  });

  factory ShopProductAttribute.fromJson(Map<String, dynamic> json) {
    return ShopProductAttribute(
      attributeName: json['attributeName'] ?? '',
      attributeUuid: json['attributeUuid'] ?? '',
      properties: (json['properties'] as List<dynamic>? ?? [])
          .map((e) => ShopProductProperty.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'attributeName': attributeName,
    'attributeUuid': attributeUuid,
    'properties': properties.map((e) => e.toJson()).toList(),
  };

  @override
  List<Object?> get props => [attributeName, attributeUuid, properties];
}

class ShopProduct extends Equatable {
  final String uuid;
  final String name;
  final String description;
  final String categoryName;
  final String brandName;
  final String sku;
  final bool isFeatured;
  final double price;
  final String imageUrl;
  final List<String> images;
  final List<ShopProductAttribute> attributes;

  const ShopProduct({
    required this.uuid,
    required this.name,
    required this.description,
    required this.categoryName,
    required this.brandName,
    required this.sku,
    required this.isFeatured,
    required this.attributes,
    this.price = 0,
    this.imageUrl = '',
    this.images = const [],
  });

  factory ShopProduct.fromJson(Map<String, dynamic> json) {
    return ShopProduct(
      uuid: json['uuid'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      categoryName: json['categoryName'] ?? '',
      brandName: json['brandName'] ?? '',
      sku: json['sku'] ?? '',
      isFeatured: json['isFeatured'] ?? false,
      price: (json['price'] ?? 0).toDouble() ?? 0.0,
      imageUrl: json['imageUrl'] ?? '',
      images: (json['images'] as List<dynamic>? ?? [])
          .map((e) => e as String)
          .toList(),
      attributes: (json['attributes'] as List<dynamic>? ?? [])
          .map((e) => ShopProductAttribute.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'uuid': uuid,
    'name': name,
    'description': description,
    'categoryName': categoryName,
    'brandName': brandName,
    'sku': sku,
    'isFeatured': isFeatured,
    'price': price,
    'imageUrl': imageUrl,
    'images': images.map((e) => e).toList(),
    'attributes': attributes.map((e) => e.toJson()).toList(),
  };

  @override
  List<Object?> get props => [
    uuid,
    name,
    description,
    categoryName,
    brandName,
    sku,
    isFeatured,
    attributes,
    price,
    imageUrl,
    images,
  ];
}
