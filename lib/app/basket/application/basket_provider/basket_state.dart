import 'package:equatable/equatable.dart';
import 'package:service_shop/app/core/models/products/product.dart';
import 'package:service_shop/app/shop/domain/models/shop.dart';

class BasketState extends Equatable {
  final List<BasketShopItem> shopItems;

  const BasketState({this.shopItems = const []});

  factory BasketState.initial() {
    return const BasketState(shopItems: []);
  }

  double get totalAmount {
    double total = 0.0;
    for (var shopItem in shopItems) {
      total += shopItem.totalAmount;
    }
    return total;
  }

  double get totalCount {
    double count = 0.0;
    for (var shopItem in shopItems) {
      for (var product in shopItem.products) {
        count += product.quantity;
      }
    }
    return count;
  }

  double get totalShops {
    return shopItems.length.toDouble();
  }

  double get totalDeliveryCost {
    double total = 0.0;
    for (var shopItem in shopItems) {
      total += shopItem.deliveryCost;
    }
    return total;
  }

  Map<String, dynamic> toJson() {
    return {
      'shopItems': shopItems.map((e) => e.toJson()).toList(),
    };
  }

  @override
  List<Object?> get props => [shopItems];

  double getProductCount(Product product, String branchUuid) {
    final shopItem = shopItems.firstWhere(
      (shopItem) => shopItem.shop.id == branchUuid,
      orElse: () => BasketShopItem.initial(),
    );
    if (shopItem.shop.id.isEmpty) return 0;

    final productItem = shopItem.products.firstWhere(
      (prod) => prod.propertyUuid == product.propertyUuid,
      orElse: () => Product.empty(),
    );
    if (productItem.propertyUuid.isEmpty) return 0;

    return productItem.quantity;
  }
}

class BasketShopItem extends Equatable {
  final Shop shop;
  final List<Product> products;
  final double totalAmount;
  final String deliveryType;
  final double deliveryCost;

  const BasketShopItem({
    required this.shop,
    this.products = const [],
    this.totalAmount = 0.0,
    required this.deliveryType,
    required this.deliveryCost,
  });

  factory BasketShopItem.initial() {
    return BasketShopItem(
      shop: Shop.empty(),
      products: [],
      totalAmount: 0.0,
      deliveryType: 'Самовывоз',
      deliveryCost: 0,
    );
  }

  toJson() {
    return {
      'shop': shop.toJson(),
      'products': products.map((e) => e.toJson()).toList(),
      'totalAmount': totalAmount,
      'deliveryType': deliveryType,
      'deliveryCost': deliveryCost,
    };
  }

  copyWith({
    Shop? shop,
    List<Product>? products,
    double? totalAmount,
    String? deliveryType,
    double? deliveryCost,
  }) {
    return BasketShopItem(
      shop: shop ?? this.shop,
      products: products ?? this.products,
      totalAmount: totalAmount ?? this.totalAmount,
      deliveryType: deliveryType ?? this.deliveryType,
      deliveryCost: deliveryCost ?? this.deliveryCost,
    );
  }

  @override
  List<Object?> get props => [shop, products, totalAmount, deliveryType];
}
