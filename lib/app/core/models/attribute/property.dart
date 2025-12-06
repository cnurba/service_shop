import 'package:equatable/equatable.dart';
import 'package:service_shop/app/core/models/attribute/attribute.dart';

class Property extends Equatable {
  final String propertyValue;
  final String propertyUuid;
  final String propertyPicture;
  final bool selected;
  final List<Attribute> children;

  const Property({
    required this.propertyValue,
    required this.propertyUuid,
    required this.children,
    this.propertyPicture = '',
    this.selected = false,
  });

  Property copyWith({
    String? propertyValue,
    String? propertyUuid,
    bool? selected,
    String? propertyPicture,
    List<Attribute>? children,
  }) {
    return Property(
      propertyValue: propertyValue ?? this.propertyValue,
      propertyUuid: propertyUuid ?? this.propertyUuid,
      selected: selected ?? this.selected,
      propertyPicture: propertyPicture ?? this.propertyPicture,
      children: children ?? this.children,
    );
  }

  factory Property.fromJson(Map<String, dynamic> json) {
    return Property(
      propertyValue: json['propertyValue'] as String? ?? '',
      propertyUuid: json['propertyUuid'] as String? ?? '',
      selected: json['selected'] as bool? ?? false,
      propertyPicture: json['propertyPicture'] as String? ?? '',
      children: (json['children'] as List<dynamic>? ?? [])
          .map((e) => Attribute.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  factory Property.fromJsonWithoutChildren(Map<String, dynamic> json) {
    return Property(
      propertyValue: json['propertyValue'] as String? ?? '',
      propertyUuid: json['propertyUuid'] as String? ?? '',
      selected: false,
      propertyPicture: '',
      children: [],
    );
  }

  Map<String, dynamic> toJson() => {
    'propertyValue': propertyValue,
    'propertyUuid': propertyUuid,
    'selected': selected,
    'propertyPicture': propertyPicture,
  };

  @override
  List<Object?> get props => [
    propertyValue,
    propertyUuid,
    selected,
    propertyPicture,
    children,
  ];

  @override
  String toString() =>
      'Property(propertyValue: $propertyValue, propertyUuid: $propertyUuid propertyUuid: $propertyPicture, selected: $selected)';
}
