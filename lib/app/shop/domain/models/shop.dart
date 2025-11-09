import 'package:equatable/equatable.dart';
import 'package:service_shop/app/shop/domain/models/delivery.dart';

class Shop extends Equatable {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String address;
  final String phone;
  final String email;
  final String workingHours;
  final String location;
  final double rating;
  final int discountPercent;
  final int minOrderAmount;
  final bool isOpen;
  final String status;
  final List<String> images;
  final String category;
  final List<String> categories;
  final List<Delivery> deliveries;

  const Shop({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
    required this.address,
    required this.phone,
    required this.email,
    required this.workingHours,
    required this.location,
    required this.rating,
    required this.discountPercent,
    required this.minOrderAmount,
    required this.isOpen,
    required this.status,
    required this.images,
    required this.category,
    required this.categories,
    required this.deliveries,
  });

  factory Shop.empty() {
    return Shop(
      id: '',
      name: '',
      description: '',
      imageUrl: '',
      isActive: false,
      createdAt: DateTime(0001),
      updatedAt: DateTime(0001),
      address: '',
      phone: '',
      email: '',
      workingHours: '',
      location: '',
      rating: 0.0,
      discountPercent: 0,
      minOrderAmount: 0,
      isOpen: false,
      status: '',
      images: const [],
      category: '',
      categories: const [],
      deliveries: const [],
    );
  }

  factory Shop.fromJson(Map<String, dynamic> json) {
    return Shop(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      isActive: json['isActive'] ?? false,
      createdAt: DateTime.parse(
        json['createdAt'] ?? DateTime(0001).toIso8601String(),
      ),
      updatedAt: DateTime.parse(
        json['updatedAt'] ?? DateTime(0001).toIso8601String(),
      ),
      address: json['address'] ?? '',
      phone: json['phone'] ?? '',
      email: json['email'] ?? '',
      workingHours: json['workingHours'] ?? '',
      location: json['location'] ?? '',
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      discountPercent: json['discountPercent'] ?? 0,
      minOrderAmount: json['minOrderAmount'] ?? 0,
      isOpen: json['isOpen'] ?? false,
      status: json['status'] ?? '',
      images:
          (json['images'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      category: json['category'] ?? '',
      categories:
          (json['categories'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      deliveries:
          (json['deliveries'] as List<dynamic>?)
              ?.map((e) => Delivery.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'isActive': isActive,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'address': address,
      'phone': phone,
      'email': email,
      'workingHours': workingHours,
      'location': location,
      'rating': rating,
      'discountPercent': discountPercent,
      'minOrderAmount': minOrderAmount,
      'isOpen': isOpen,
      'status': status,
      'images': images,
      'category': category,
      'categories': categories,
      'deliveries': deliveries.map((e) => e.toJson()).toList(),
    };
  }

  @override
  List<Object?> get props => [
    id,
    name,
    description,
    imageUrl,
    isActive,
    createdAt,
    updatedAt,
    address,
    phone,
    email,
    workingHours,
    location,
    rating,
    discountPercent,
    minOrderAmount,
    isOpen,
    status,
    images,
    category,
    categories,
    deliveries,
  ];
}
