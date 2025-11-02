import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:service_shop/app/core/models/attribute/attribute.dart';
import 'package:service_shop/app/core/models/attribute/property.dart';
import 'package:service_shop/app/core/models/data_tree.dart';
import 'package:service_shop/app/core/models/products/product.dart';
import 'package:service_shop/app/shop/application/product/product_detail_state.dart';
import 'package:service_shop/app/core/models/product_with_properties.dart';

final productDetailProvider =
    StateNotifierProvider<ProductController, ProductDetailState>((ref) {
  return ProductController();
});

class ProductController extends StateNotifier<ProductDetailState> {
  ProductController() : super(ProductDetailState.initial());

  Future<void> initialize({required DataTree dataTree, required Product product}) async {
    // Установим дерево и проставим значения по-умолчанию (первое свойство) рекурсивно
    Attribute setDefaults(Attribute attr) {
      // обработаем детей свойств сначала
      final newChildren = attr.children.map((prop) {
        final childAttrs = prop.children.map(setDefaults).toList();
        return prop.copyWith(children: childAttrs);
      }).toList();

      // если ни у одного свойства не выбран флаг selected, то установим первый
      final hasSelected = newChildren.any((p) => p.selected);
      final finalChildren = hasSelected
          ? newChildren
          : (newChildren.isNotEmpty
              ? newChildren.asMap().entries.map((e) {
                  if (e.key == 0) return e.value.copyWith(selected: true);
                  return e.value;
                }).toList()
              : newChildren);

      return Attribute(attributeName: attr.attributeName, attributeUuid: attr.attributeUuid, children: finalChildren);
    }

    final tree = dataTree.tree.map(setDefaults).toList();

    state = state.copyWith(originalTree: dataTree, tree: tree, currentProduct: product);

    // DEBUG: print tree structure
    void _printTree() {
      StringBuffer sb = StringBuffer();
      void walk(Attribute a, String indent) {
        sb.writeln('$indent- Attribute: ${a.attributeName} (${a.attributeUuid})');
        for (final p in a.children) {
          sb.writeln('$indent    * Property: ${p.propertyValue} (${p.propertyUuid}) selected=${p.selected} picture=${p.propertyPicture}');
          for (final ca in p.children) walk(ca, '$indent        ');
        }
      }
      for (final r in state.tree) walk(r, '');
      // ignore: avoid_print
      print('DataTree after initialize:\n${sb.toString()}');
    }

    _printTree();

    _syncCurrentProduct();
  }

  // Синхронизирует currentProduct на основе выбранных свойств
  void _syncCurrentProduct() {
    final selected = <String>{};

    void collect(Attribute attr) {
      for (final prop in attr.children) {
        if (prop.selected) selected.add(prop.propertyUuid);
        for (final child in prop.children) collect(child);
      }
    }

    for (final root in state.tree) collect(root);

    Product? matched;
    for (final pw in state.originalTree.data) {
      final pwSet = pw.properties.map((p) => p.propertyUuid).toSet();
      if (selected.every((s) => pwSet.contains(s))) {
        matched = pw.product;
        break;
      }
    }

    if (matched != null) {
      state = state.copyWith(currentProduct: matched);
    }
  }

  // Очищает все selected в поддереве атрибута
  Attribute _clearSelections(Attribute attr) {
    final newChildren = attr.children.map((prop) {
      final clearedChildAttrs = prop.children.map(_clearSelections).toList();
      return prop.copyWith(selected: false, children: clearedChildAttrs);
    }).toList();
    return Attribute(attributeName: attr.attributeName, attributeUuid: attr.attributeUuid, children: newChildren);
  }

  // Устанавливает defaults (первое) рекурсивно для атрибута
  Attribute _setDefaults(Attribute attr) {
    final newChildren = attr.children.map((prop) {
      final childAttrs = prop.children.map(_setDefaults).toList();
      return prop.copyWith(children: childAttrs);
    }).toList();

    final hasSelected = newChildren.any((p) => p.selected);
    if (!hasSelected && newChildren.isNotEmpty) {
      finalChildrenAssign(List<Property> list) {
        list[0] = list[0].copyWith(selected: true);
      }
      // create mutable copy
      final tmp = newChildren.toList();
      tmp[0] = tmp[0].copyWith(selected: true);
      return Attribute(attributeName: attr.attributeName, attributeUuid: attr.attributeUuid, children: tmp);
    }

    return Attribute(attributeName: attr.attributeName, attributeUuid: attr.attributeUuid, children: newChildren);
  }

  /// Обновляет выбор свойства для атрибута с заданным attributeUuid.
  /// Логика: находим атрибут (первое совпадение по attributeUuid при рекурсивном обходе),
  /// отмечаем выбранное свойство, очищаем selections у остальных веток, и
  /// проставляем defaults в дочерних атрибутах выбранного свойства.
  void updateProperties(Attribute targetAttribute, Property selectedProperty) {
    bool updated = false;

    Attribute _update(Attribute attr) {
      if (!updated && attr.attributeUuid == targetAttribute.attributeUuid) {
        // обновляем этот атрибут: ставим selected только на выбранное свойство
        final newChildren = attr.children.map((prop) {
          if (prop.propertyUuid == selectedProperty.propertyUuid) {
            // для выбранного свойства — оставляем selected и проставляем defaults в его дочерних атрибутах
            final childAttrsWithDefaults = prop.children.map((childAttr) => _setDefaults(childAttr)).toList();
            return prop.copyWith(selected: true, children: childAttrsWithDefaults);
          } else {
            // для невыбранных — очистим их поддеревья
            final cleared = prop.children.map((c) => _clearSelections(c)).toList();
            return prop.copyWith(selected: false, children: cleared);
          }
        }).toList();

        updated = true;
        return Attribute(attributeName: attr.attributeName, attributeUuid: attr.attributeUuid, children: newChildren);
      }

      // иначе рекурсивно обходим детей
      final newChildren = attr.children.map((prop) {
        final updatedChildAttrs = prop.children.map(_update).toList();
        return prop.copyWith(children: updatedChildAttrs);
      }).toList();

      return Attribute(attributeName: attr.attributeName, attributeUuid: attr.attributeUuid, children: newChildren);
    }

    final newTree = state.tree.map((root) => _update(root)).toList();

    // После обновления дерева — гарантируем, что в каждом атрибуте есть хотя бы один selected (для дочерних мы уже устанавливали defaults)
    Attribute ensureDefaults(Attribute attr) {
      final newChildren = attr.children.map((prop) {
        final childAttrs = prop.children.map(ensureDefaults).toList();
        return prop.copyWith(children: childAttrs);
      }).toList();
      final hasSelected = newChildren.any((p) => p.selected);
      if (!hasSelected && newChildren.isNotEmpty) {
        final tmp = newChildren.toList();
        tmp[0] = tmp[0].copyWith(selected: true);
        return Attribute(attributeName: attr.attributeName, attributeUuid: attr.attributeUuid, children: tmp);
      }
      return Attribute(attributeName: attr.attributeName, attributeUuid: attr.attributeUuid, children: newChildren);
    }

    final cleaned = newTree.map(ensureDefaults).toList();

    state = state.copyWith(tree: cleaned);

    // DEBUG: print tree after update
    void _printAfterUpdate() {
      StringBuffer sb = StringBuffer();
      void walk(Attribute a, String indent) {
        sb.writeln('$indent- Attribute: ${a.attributeName} (${a.attributeUuid})');
        for (final p in a.children) {
          sb.writeln('$indent    * Property: ${p.propertyValue} (${p.propertyUuid}) selected=${p.selected}');
          for (final ca in p.children) walk(ca, '$indent        ');
        }
      }
      for (final r in state.tree) walk(r, '');
      // ignore: avoid_print
      print('DataTree after updateProperties:\n${sb.toString()}');
    }

    _printAfterUpdate();
    _setSelectedInAttribute(targetAttribute.attributeUuid, selectedProperty.propertyUuid);
    _selectFirstInDescendants(selectedProperty);

    _syncCurrentProduct();
  }

  void _setSelectedInAttribute(String attributeUuid, String propertyUuid) {
    for (final attr in state.tree) {
      if (attr.attributeUuid == attributeUuid) {
        for (final p in attr.children) {
          p.copyWith(selected:  p.propertyUuid == propertyUuid);
        }
        return;
      }
      // тоже проверяем вложенные атрибуты на случай рекурсивной структуры
      _setSelectedInAttributeRecursive(attr, attributeUuid, propertyUuid);
    }
  }

  bool _setSelectedInAttributeRecursive(Attribute node, String attributeUuid, String propertyUuid) {
    // Проходим по свойствам, у которых могут быть вложенные атрибуты
    for (final prop in node.children) {
      for (final childAttr in prop.children) {
        if (childAttr.attributeUuid == attributeUuid) {
          for (final p in childAttr.children) {
            p.copyWith(selected:  p.propertyUuid == propertyUuid);
          }
          return true;
        }
        if (_setSelectedInAttributeRecursive(childAttr, attributeUuid, propertyUuid)) {
          return true;
        }
      }
    }
    return false;
  }

  void _selectFirstInDescendants(Property property) {
    // Для каждого дочернего атрибута текущего property проставляем первый property.selected = true
    for (final childAttr in property.children) {
      if (childAttr.children.isNotEmpty) {
        // Сброс остальных и выбор первого
        for (final p in childAttr.children) {
          p.copyWith(selected:  false);
        }
        final first = childAttr.children.first;
        first.selected = true;

        // Рекурсивно для выбранного первого свойства
        _selectFirstInDescendants(first);
      }
    }
  }
}
