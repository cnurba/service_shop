import 'package:equatable/equatable.dart';

class MyAddressModel extends Equatable {
  final String id;
  final String name;
  final String phone;
  final String city;
  final String street;
  final String apartment;
  final bool isDefault;

  const MyAddressModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.city,
    required this.street,
    required this.apartment,
    this.isDefault = false,
  });

  String get fullAddress {
    return 'г. $city, ул. $street, $apartment';
  }

  factory MyAddressModel.fromJson(Map<String, dynamic> json) {
    return MyAddressModel(
      id: (json['id'] ?? '').toString(),
      name: json['name'] ?? '',
      phone: json['phone'] ?? '',
      city: json['city'] ?? '',
      street: json['street'] ?? '',
      apartment: json['apartment'] ?? '',
      isDefault: json['default'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'phone': phone,
      'city': city,
      'street': street,
      'apartment': apartment,
      'default': isDefault,
    };
  }

  @override
  List<Object?> get props => [id, phone, city, street, apartment, isDefault];
}
