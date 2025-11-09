import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:service_shop/app/core/models/attribute/attribute.dart';
import 'package:service_shop/app/core/models/attribute/property.dart';
import 'package:service_shop/app/core/models/data_tree.dart';
import 'package:service_shop/app/core/models/products/product.dart';
import 'package:service_shop/app/shop/application/product/product_detail_state.dart';

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
    // Собираем выбранные свойства по одной активной ветке: начинаем с первого корневого атрибута
    void collectPath(Attribute attr) {
      if (attr.children.isEmpty) return;
      // Найдём выбранное свойство в этом атрибуте (или первый элемент как fallback)
      final sel = attr.children.firstWhere((p) => p.selected, orElse: () => attr.children.first);
      selected.add(sel.propertyUuid);
      // Рекурсивно спускаемся по дочерним атрибутам выбранного свойства
      for (final childAttr in sel.children) {
        collectPath(childAttr);
      }
    }

    if (state.tree.isNotEmpty) {
      collectPath(state.tree.first);
    }
    // DEBUG: покажем выбранные UUID
    // ignore: avoid_print
    print('syncCurrentProduct: selected=${selected.toList()} ');

    Product? matched;
    for (final pw in state.originalTree.data) {
      final pwSet = pw.properties.map((p) => p.propertyUuid).toSet();
      // Требуется точное совпадение наборов свойств: множества должны быть равны.
      if (pwSet.length == selected.length && pwSet.containsAll(selected)) {
        matched = pw.product;
        // ignore: avoid_print
        print('syncCurrentProduct: matched product propertyUuid=${pw.product.propertyUuid} price=${pw.product.propertyName}');
        break;
      }
    }
    // если нет точного совпадения — устанавливаем пустой Product (или можно оставить предыдущий)
    final currentProduct = matched ?? Product.empty();
    state = state.copyWith(currentProduct: currentProduct.copyWith(count: 1));
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
      // create mutable copy и пометить первый как selected
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
  void updateProperties(String targetAttributeUuid, String selectedPropertyUuid, {String parentPropertyUuid = ''}) {
    // DEBUG: логируем, какой атрибут и свойство выбраны
    // ignore: avoid_print
    print('updateProperties called: attributeUuid=$targetAttributeUuid, propertyUuid=$selectedPropertyUuid, parentPropertyUuid=$parentPropertyUuid');
    bool updated = false;

    Attribute _update(Attribute attr, {String currentParentPropertyUuid = ''}) {
      if (!updated && attr.attributeUuid == targetAttributeUuid && currentParentPropertyUuid == parentPropertyUuid) {
        // обновляем этот атрибут: ставим selected только на выбранное свойство
        final newChildren = attr.children.map((prop) {
            if (prop.propertyUuid == selectedPropertyUuid) {
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

      // иначе рекурсивно обходим детей: при рекурсии parentPropertyUuid становится uuid текущего prop
      final newChildren = attr.children.map((prop) {
          final updatedChildAttrs = prop.children.map((childAttr) => _update(childAttr, currentParentPropertyUuid: prop.propertyUuid)).toList();
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
    // Выбор и проставление defaults уже выполнены выше (в _update и ensureDefaults).
    _syncCurrentProduct();
  }

  void addCount() {
    final newCount = state.currentProduct.count + 1;
    state = state.copyWith(currentProduct: state.currentProduct.copyWith(count: newCount));
  }

  void removeCount() {
    if (state.currentProduct.count > 1) {
      final newCount = state.currentProduct.count - 1;
      state = state.copyWith(currentProduct: state.currentProduct.copyWith(count: newCount));
    }
  }

}
