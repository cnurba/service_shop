import 'package:equatable/equatable.dart';
import 'package:service_shop/app/core/models/products/product.dart';
import 'package:service_shop/core/enum/delivery_type.dart';
import 'package:service_shop/core/enum/payment_type.dart';

class CheckoutState extends Equatable{
  final List<CheckoutShopItem> shopItems;
  final PaymentType paymentType;
  final bool isCombinedDelivery;
  final double totalAmount;
  final double totalCount;

  const CheckoutState({
    this.shopItems = const [],
    required this.paymentType,
    this.isCombinedDelivery = false,
    this.totalAmount = 0.0,
    this.totalCount = 0.0,

  });

  factory CheckoutState.initial() {
    return const CheckoutState(
      shopItems: [],
      paymentType: PaymentType.cash,
    );
  }

  copyWith({
    List<CheckoutShopItem>? shopItems,
    PaymentType? paymentType,
    bool? isCombinedDelivery,
    double? totalAmount,
    double? totalCount,
  }){
    return CheckoutState(
      shopItems: shopItems ?? this.shopItems,
      paymentType: paymentType ?? this.paymentType,
      isCombinedDelivery: isCombinedDelivery ?? this.isCombinedDelivery,
      totalAmount: totalAmount ?? this.totalAmount,
      totalCount: totalCount ?? this.totalCount,
    );
  }

  @override
  List<Object?> get props => [shopItems];
}

class CheckoutShopItem extends Equatable{
  final String shopId;
  final String shopName;
  final String shopImageUrl;
  final List<Product> products;
  final double totalAmount;
  final DeliveryType deliveryType;
  /// объединенная доставка

   const CheckoutShopItem({
    required this.shopId,
    required this.shopName,
    required this.shopImageUrl,
    this.products = const [],
    this.totalAmount = 0.0,
    required this.deliveryType,
  });

   copyWith({
    String? shopId,
    String? shopName,
    String? shopImageUrl,
    List<Product>? products,
    double? totalAmount,
    DeliveryType? deliveryType,
  }){
    return CheckoutShopItem(
      shopId: shopId ?? this.shopId,
      shopName: shopName ?? this.shopName,
      shopImageUrl: shopImageUrl ?? this.shopImageUrl,
      products: products ?? this.products,
      totalAmount: totalAmount ?? this.totalAmount,
      deliveryType: deliveryType ?? this.deliveryType,
    );
   }

  factory CheckoutShopItem.initial() {
    return const CheckoutShopItem(
      shopId: '',
      shopName: '',
      shopImageUrl: '',
      products: [],
      totalAmount: 0.0,
      deliveryType: DeliveryType.pickup,
    );
  }

  @override
  List<Object?> get props => [shopId, shopName, shopImageUrl,products, totalAmount,deliveryType];
}