import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:service_shop/app/basket/application/basket_provider/basket_controller.dart';
import 'package:service_shop/app/shop/application/product/product_detail_controller.dart';
import 'package:service_shop/app/shop/application/product/product_detail_state.dart';
import 'package:service_shop/app/shop/application/shops/shops_provider.dart';
import 'package:service_shop/app/shop/presentation/widgets/add_remove_button.dart';
import 'package:service_shop/app/shop/presentation/widgets/shop_attribute_select_widget.dart';
import 'package:service_shop/core/presentation/image/carousel_slider.dart';
import 'package:service_shop/core/presentation/theme/colors.dart';
import 'package:service_shop/app/core/models/property_attribute.dart';
import 'package:service_shop/app/core/models/attribute/attribute.dart';

class ProductDetailScreen extends ConsumerWidget {
  const ProductDetailScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ProductDetailState state = ref.watch(productDetailProvider);
    final product = state.currentProduct;
    final tree = state.tree;

    Widget buildAttribute(
      Attribute attr, {
      bool isMain = false,
      String parentPropertyUuid = '',
    }) {
      final currentAttr = attr;
      final properties = attr.children;
      if (properties.isEmpty) return const SizedBox.shrink();

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            child: Text(
              currentAttr.attributeName,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),

          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                ShopAttributeSelectWidget(
                  key: ValueKey(
                    '${currentAttr.attributeUuid}_$parentPropertyUuid',
                  ),
                  isMainAttribute: isMain,
                  attribute: PropertyAttribute(
                    attribute: attr,
                    properties: properties,
                  ),
                  onSelected: (property) {
                    ref
                        .read(productDetailProvider.notifier)
                        .updateProperties(
                          currentAttr.attributeUuid,
                          property.propertyUuid,
                          parentPropertyUuid: parentPropertyUuid,
                        );
                  },
                ),
              ],
            ),
          ),
          for (final prop in properties)
            if (prop.selected)
              for (final childAttr in prop.children)
                buildAttribute(
                  childAttr,
                  isMain: false,
                  parentPropertyUuid: prop.propertyUuid,
                ),
        ],
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(product.name.isNotEmpty ? product.name : ''),
        backgroundColor: ServiceColors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CarouselSlider(images: product.images, sliderHeight: 300),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    product.propertyName,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${state.currentProduct.quantity} шт',
                    style: const TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 4),

                  Row(
                    children: [
                      AddRemoveButton(
                        count: ref
                            .watch(basketProvider)
                            .getProductCount(product, product.branchUuid),
                        onAdd: () {
                          ref.read(productDetailProvider.notifier).addCount();
                          final shop = ref
                              .read(shopsProvider)
                              .shops
                              .where((e) => e.id == product.branchUuid)
                              .first;
                          ref.read(basketProvider.notifier).add(product, shop);
                        },
                        onRemove: () {
                          ref
                              .read(basketProvider.notifier)
                              .onMinusCount(product, product.branchUuid);
                        },
                      ),
                      const Spacer(),
                      Text(
                        '${state.currentProduct.price} с',
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
              for (var i = 0; i < tree.length; i++)
                buildAttribute(tree[i], isMain: i == 0),
            ],
            // Характеристика и описание
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Характеристика и описание',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(product.description),
                  const SizedBox(height: 4),
                  Text(
                    'Артикул: ${product.sku}',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
