import 'package:equatable/equatable.dart';

class PropertyWithPrice extends Equatable {
  final String propertyValue;
  final String propertyUuid;
  final double price;
  final double count;

  const PropertyWithPrice({
    required this.propertyValue,
    required this.propertyUuid,
    this.price = 0,
    this.count = 0,
  });

  @override
  List<Object?> get props => [propertyValue, propertyUuid, price, count];

  factory PropertyWithPrice.fromJson(Map<String, dynamic> json) {
    final price = (json['price'] ?? 0).toDouble();
    final count = (json['count'] ?? 0).toDouble();

    return PropertyWithPrice(
      propertyValue: json['propertyValue'] as String? ?? '',
      propertyUuid: json['propertyUuid'] as String? ?? '',
      price: price,
      count: count,
    );
  }


}
