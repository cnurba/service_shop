import 'package:equatable/equatable.dart';
import 'package:service_shop/app/basket/application/basket_provider/basket_state.dart';

class CheckoutState extends Equatable {
  final List<BasketShopItem> shopItems;
  final String paymentType;
  final String name;
  final String phone;
  final String city;
  final String street;
  final String apartment;
  final bool saveInfo;
  final int totalShops;
  final double totalCount;
  final double totalAmount;
  final double deliveryCost;
  final double finalAmount;

  const CheckoutState({
    this.shopItems = const [],
    required this.paymentType,
    required this.totalAmount,
    required this.totalCount,
    required this.name,
    required this.phone,
    required this.city,
    required this.street,
    required this.apartment,
    required this.saveInfo,
    required this.deliveryCost,
    required this.finalAmount,
    required this.totalShops,
  });

  factory CheckoutState.initial() {
    return const CheckoutState(
      shopItems: [],
      paymentType: "Онлайн",
      totalAmount: 0.0,
      totalCount: 0.0,
      name: '',
      phone: '',
      city: '',
      street: '',
      apartment: '',
      saveInfo: false,
      deliveryCost: 0.0,
      finalAmount: 0.0,
      totalShops: 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'shopItems': shopItems.map((e) => e.toJson()).toList(),
      'paymentType': paymentType,
      'name': name,
      'phone': phone,
      'city': city,
      'street': street,
      'apartment': apartment,
      'saveInfo': saveInfo,
      'totalAmount': totalAmount,
      'totalCount': totalCount,
      'deliveryCost': deliveryCost,
      'finalAmount': finalAmount,
      'totalShops': totalShops,
    };
  }

  copyWith({
    List<BasketShopItem>? shopItems,
    String? paymentType,
    String? name,
    String? phone,
    String? city,
    String? street,
    String? apartment,
    bool? saveInfo,
    double? totalAmount,
    double? totalCount,
    double? deliveryCost,
    double? finalAmount,
    int? totalShops,
  }) {
    return CheckoutState(
      shopItems: shopItems ?? this.shopItems,
      paymentType: paymentType ?? this.paymentType,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      city: city ?? this.city,
      street: street ?? this.street,
      apartment: apartment ?? this.apartment,
      saveInfo: saveInfo ?? this.saveInfo,
      deliveryCost: deliveryCost ?? this.deliveryCost,
      finalAmount: finalAmount ?? this.finalAmount,
      totalAmount: totalAmount ?? this.totalAmount,
      totalCount: totalCount ?? this.totalCount,
      totalShops: totalShops ?? this.totalShops,
    );
  }

  @override
  List<Object?> get props => [
    shopItems,
    paymentType,
    name,
    phone,
    city,
    street,
    apartment,
    saveInfo,
    totalAmount,
    totalCount,
    deliveryCost,
    finalAmount,
    totalShops,
  ];
}
