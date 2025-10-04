import 'package:flutter/material.dart';
import 'package:service_shop/app/shop/domain/models/shop_products.dart';
import 'package:service_shop/app/shop/presentation/widgets/add_remove_button.dart';
import 'package:service_shop/app/shop/presentation/widgets/shop_attribute_select_widget.dart';
import 'package:service_shop/core/presentation/image/carousel_slider.dart';
import 'package:service_shop/core/presentation/theme/colors.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key, required this.product});
  final ShopProduct product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(product.name)),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(images: product.images, sliderHeight: 250),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text('20 шт', style: const TextStyle(color: Colors.grey)),
                  Row(
                    children: [
                      AddRemoveButton(count: 1, onAdd: () {}, onRemove: () {}),
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
            // Атрибуты товара
            ...product.attributes.map((attr) {
              return ShopAttributeSelectWidget(
                attribute: attr,
                onSelected: (attributeName, propertyValue) {},
              );
            }),
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
                  Text('Производитель: ${product.brandName}'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
