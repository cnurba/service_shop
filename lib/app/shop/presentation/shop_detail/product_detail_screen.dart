import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:service_shop/app/shop/application/product/product_detail_controller.dart';
import 'package:service_shop/app/shop/application/product/product_detail_state.dart';
import 'package:service_shop/app/shop/presentation/widgets/add_remove_button.dart';
import 'package:service_shop/app/shop/presentation/widgets/shop_attribute_select_widget.dart';
import 'package:service_shop/core/presentation/image/carousel_slider.dart';
import 'package:service_shop/core/presentation/theme/colors.dart';
import 'package:service_shop/app/core/models/property_attribute.dart';
import 'package:service_shop/app/core/models/attribute/attribute.dart';
import 'package:service_shop/app/core/models/attribute/property.dart';

class ProductDetailScreen extends ConsumerWidget {
  const ProductDetailScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ProductDetailState state = ref.watch(productDetailProvider);
    final product = state.currentProduct;
    final tree = state.tree;

    Widget buildAttribute(Attribute attr, {bool isMain = false}) {
      // properties to show = attr.children
      final properties = attr.children;
      if (properties.isEmpty) return const SizedBox.shrink();

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ShopAttributeSelectWidget(
            isMainAttribute: isMain,
            attribute: PropertyAttribute(attribute: attr, properties: properties),
            onSelected: (property) {
              ref.read(productDetailProvider.notifier).updateProperties(attr, property);
            },
          ),
          // render children attributes for the selected property
          for (final prop in properties)
            if (prop.selected)
              for (final childAttr in prop.children)
                buildAttribute(childAttr, isMain: false),
        ],
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text(product.name.isNotEmpty ? product.name : '')),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CarouselSlider(
              images: product.images,
              sliderHeight: 250,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${product.count} шт',
                    style: const TextStyle(color: Colors.grey),
                  ),
                  Row(
                    children: [
                      AddRemoveButton(count: state.count.toInt(), onAdd: () {}, onRemove: () {}),
                      const Spacer(),
                      Text(
                        '${product.price} с',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: ServiceColors.primaryColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Render root attributes (each root is an Attribute)
            if (tree.isNotEmpty) ...[
              for (var i = 0; i < tree.length; i++) buildAttribute(tree[i], isMain: i == 0),
            ],

            // Характеристика и описание
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Характеристика и описание',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text('Артикул: ${product.sku}'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
