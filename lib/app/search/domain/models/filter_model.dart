import 'package:equatable/equatable.dart';

class FilterModel extends Equatable {
  final String attributeName;
  final String attributeUuid;
  final List<FilterPropertyModel> children;

  const FilterModel({
    required this.attributeName,
    required this.attributeUuid,
    required this.children,
  });

  factory FilterModel.fromJson(Map<String, dynamic> json) {
    return FilterModel(
      attributeName: json['attributeName'] as String,
      attributeUuid: json['attributeUuid'] as String,
      children: (json['children'] as List<dynamic>? ?? [])
          .map((e) => FilterPropertyModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'attributeName': attributeName,
      'attributeUuid': attributeUuid,
      'children': children.map((e) => {
        'attributeUuid': e.attributeUuid,
        'propertyName': e.propertyName,
        'propertyUuid': e.propertyUuid,
      }).toList(),
    };
  }

  @override
  List<Object?> get props => [attributeName, attributeUuid, children];
}

class FilterPropertyModel extends Equatable {
  final String attributeUuid;
  final String propertyName;
  final String propertyUuid;

  const FilterPropertyModel({
    required this.attributeUuid,
    required this.propertyName,
    required this.propertyUuid,
  });

  factory FilterPropertyModel.fromJson(Map<String, dynamic> json) {
    return FilterPropertyModel(
      attributeUuid: json['attributeUuid'] as String,
      propertyName: json['propertyName'] as String,
      propertyUuid: json['propertyUuid'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'attributeUuid': attributeUuid,
      'propertyName': propertyName,
      'propertyUuid': propertyUuid,
    };
  }

  @override
  List<Object?> get props => [attributeUuid, propertyName, propertyUuid];
}
