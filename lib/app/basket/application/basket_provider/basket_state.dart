import 'package:equatable/equatable.dart';
import 'package:service_shop/app/core/models/products/product.dart';

class BasketState extends Equatable{
  final List<BasketShopItem> shopItems;

  const BasketState({
    this.shopItems = const [],
  });

  factory BasketState.initial() {
    return const BasketState(
      shopItems: [],
    );
  }

  @override
  List<Object?> get props => [shopItems];

  double getProductCount(Product product, String branchUuid) {
    final shopItem = shopItems.firstWhere(
      (shop) => shop.shopId == branchUuid,
      orElse: () => BasketShopItem.initial(),
    );
    if (shopItem.shopId.isEmpty) return 0;

    final productItem = shopItem.products.firstWhere(
      (prod) => prod.propertyUuid == product.propertyUuid,
      orElse: () => Product.empty(),
    );
    if (productItem.propertyUuid.isEmpty) return 0;

    return productItem.quantity;
  }
}

class BasketShopItem extends Equatable{
  final String shopId;
  final String shopName;
  final String shopImageUrl;
  final List<Product> products;
  final double totalAmount;

  const BasketShopItem({
    required this.shopId,
    required this.shopName,
    required this.shopImageUrl,
    this.products = const [],
    this.totalAmount = 0.0,
  });

  factory BasketShopItem.initial() {
    return const BasketShopItem(
      shopId: '',
      shopName: '',
      shopImageUrl: '',
      products: [],
      totalAmount: 0.0,
    );
  }

  copyWith({
    String? shopId,
    String? shopName,
    String? shopImageUrl,
    List<Product>? products,
    double? totalAmount,
  }) {
    return BasketShopItem(
      shopId: shopId ?? this.shopId,
      shopName: shopName ?? this.shopName,
      shopImageUrl: shopImageUrl ?? this.shopImageUrl,
      products: products ?? this.products,
      totalAmount: totalAmount ?? this.totalAmount,
    );
  }

  @override
  List<Object?> get props => [shopId, shopName, shopImageUrl,products, totalAmount];
}