import 'package:equatable/equatable.dart';
import 'package:service_shop/app/core/models/attribute/attribute.dart';
import 'package:service_shop/app/core/models/attribute/property.dart';

class PropertyAttribute extends Equatable {
  final Attribute attribute;
  final List<Property> properties;

  const PropertyAttribute({required this.attribute, required this.properties});

  factory PropertyAttribute.fromJson(Map<String, dynamic> json) {
    return PropertyAttribute(
      attribute: Attribute.fromJson(json['attribute'] as Map<String, dynamic>),
      properties: (json['properties'] as List<dynamic>? ?? [])
          .map((e) => Property.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  factory PropertyAttribute.empty() {
    return PropertyAttribute(
      attribute: Attribute.empty(),
      properties: [],
    );
  }

  Map<String, dynamic> toJson() => {
    'attribute': attribute.toJson(),
    'properties': properties.map((e) => e.toJson()).toList(),
  };

  @override
  List<Object?> get props => [attribute, properties];
}
