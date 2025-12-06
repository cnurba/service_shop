import 'package:equatable/equatable.dart';
import 'package:service_shop/app/core/models/attribute/attribute.dart';
import 'package:service_shop/app/core/models/attribute/property.dart';
import 'package:service_shop/app/core/models/product_with_properties.dart';

class DataTree extends Equatable {
  final List<ProductWithProperties> data;
  final List<Attribute> tree;

  const DataTree({required this.data, required this.tree});

  factory DataTree.empty() {
    return DataTree(data: [], tree: []);
  }

  factory DataTree.fromJson(Map<String, dynamic> json) {
    final dataList = (json['data'] as List<dynamic>? ?? [])
        .map((e) => ProductWithProperties.fromJson(e as Map<String, dynamic>))
        .toList();

    final treeList = _parseTreeRecursive(json['tree']);

    return DataTree(
      data: dataList,
      tree: treeList,
    );
  }

  @override
  List<Object?> get props => [data, tree];
}

List<Attribute> _parseTreeRecursive(dynamic treeJson) {
  if (treeJson == null) return [];

  if (treeJson is Map<String, dynamic>) {
    final map = treeJson;
    if (map.containsKey('attributeName')) {
      return [_mapToAttribute(map)];
    }

    return [];
  }

  if (treeJson is List) {
    final list = treeJson;
    return list
        .whereType<Map<String, dynamic>>()
        .map((m) => _mapToAttribute(m))
        .toList();
  }

  return [];
}

Attribute _mapToAttribute(Map<String, dynamic> map) {
  final children = (map['children'] as List<dynamic>?) ?? [];
  final parsedChildren = children
      .whereType<Map<String, dynamic>>()
      .map((childMap) {
        return _mapToProperty(childMap);
      })
      .toList();

  return Attribute(
    attributeName: map['attributeName'] as String? ?? '',
    attributeUuid: map['attributeUuid'] as String? ?? '',
    children: parsedChildren,
  );
}

Property _mapToProperty(Map<String, dynamic> map) {
  final children = (map['children'] as List<dynamic>?) ?? [];
  final parsedChildren = children
      .whereType<Map<String, dynamic>>()
      .map((childMap) {
        return _mapToAttribute(childMap);
      })
      .toList();

  return Property(
    propertyValue: map['propertyValue'] as String? ?? '',
    propertyUuid: map['propertyUuid'] as String? ?? '',
    propertyPicture: map['propertyPicture'] as String? ?? '',
    selected: map['selected'] as bool? ?? false,
    children: parsedChildren,
  );
}
