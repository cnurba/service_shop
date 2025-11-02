import 'package:equatable/equatable.dart';
import 'package:service_shop/app/core/models/all_properties/property_all.dart';
import 'package:service_shop/app/core/models/attribute/attribute.dart';
import 'package:service_shop/app/core/models/attribute/property.dart';

class PropertyAttributeValue extends Equatable {
  final String propertyValue;
  final String propertyUuid;
  final List<PropertyWithPrice> children;
  const PropertyAttributeValue({
    required this.propertyValue,
    required this.propertyUuid,
    this.children = const [],
  });

  factory PropertyAttributeValue.fromJson(Map<String, dynamic> json) {
    return PropertyAttributeValue(
      propertyValue: json['propertyValue'] as String? ?? '',
      propertyUuid: json['propertyUuid'] as String? ?? '',
      children: (json['children'] as List<dynamic>? ?? [])
          .map((e) => PropertyWithPrice.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  @override
  List<Object?> get props => [propertyValue, propertyUuid, children];


}
