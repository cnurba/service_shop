import 'package:equatable/equatable.dart';
import 'package:service_shop/app/core/models/products/product.dart';
import 'package:service_shop/app/shop/domain/models/shop.dart';

class BasketState extends Equatable {
  final List<BasketShopItem> shopItems;

  const BasketState({this.shopItems = const []});

  factory BasketState.initial() {
    return const BasketState(shopItems: []);
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

  const BasketShopItem({
    required this.shop,
    this.products = const [],
    this.totalAmount = 0.0,
  });

  factory BasketShopItem.initial() {
    return BasketShopItem(shop: Shop.empty(), products: [], totalAmount: 0.0);
  }

  copyWith({
    Shop? shop,
    List<Product>? products,
    double? totalAmount,
  }) {
    return BasketShopItem(
      shop: shop ?? this.shop,
      products: products ?? this.products,
      totalAmount: totalAmount ?? this.totalAmount,
    );
  }

  @override
  List<Object?> get props => [
    shop,
    products,
    totalAmount,
  ];
}
