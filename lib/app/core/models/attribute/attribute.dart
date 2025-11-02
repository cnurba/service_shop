import 'package:equatable/equatable.dart';
import 'package:service_shop/app/core/models/attribute/property.dart';

class Attribute extends Equatable {
  final String attributeName;
  final String attributeUuid;
  final List<Property> children;

  const Attribute({required this.attributeName, required this.attributeUuid, this.children = const []});

  factory Attribute.fromJson(Map<String, dynamic> json) {
    return Attribute(
      attributeName: json['attributeName'] as String? ?? '',
      attributeUuid: json['attributeUuid'] as String? ?? '',
      children: (json['children'] as List<dynamic>? ?? [])
          .map((e) => Property.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  factory Attribute.empty() {
    return const Attribute(
      attributeName: '',
      attributeUuid: '',
      children: [],
    );
  }

  Map<String, dynamic> toJson() => {
    'attributeName': attributeName,
    'attributeUuid': attributeUuid,
  };

  @override
  List<Object?> get props => [attributeName, attributeUuid,children];
}
