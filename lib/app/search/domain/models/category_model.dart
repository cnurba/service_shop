import 'package:equatable/equatable.dart';

class CategoryModel extends Equatable {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int sortOrder;
  final List<CategoryModel> children;

  const CategoryModel({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
    required this.sortOrder,
    required this.children,
  });

  factory CategoryModel.empty() {
    return CategoryModel(
      id: '',
      name: '',
      description: '',
      imageUrl: '',
      isActive: false,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      sortOrder: 0,
      children: [],
    );
  }
  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String? ?? '',
      imageUrl: json['imageUrl'] as String? ?? '',
      isActive: json['isActive'] as bool,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      sortOrder: json['sortOrder'] as int,
      children: (json['children'] as List<dynamic>? ?? [])
          .map((e) => CategoryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
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
    sortOrder,
    children,
  ];
}
