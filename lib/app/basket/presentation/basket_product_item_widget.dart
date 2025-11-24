import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:service_shop/app/core/models/products/product.dart';
import 'package:service_shop/core/presentation/image/app_image_container.dart';
import 'package:service_shop/core/presentation/theme/colors.dart';

class BasketProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onAdd;
  final VoidCallback onMinus;
  final VoidCallback onRemove;
  final VoidCallback onAddToFavorites;

  const BasketProductCard({
    super.key,
    required this.product,
    required this.onAdd,
    required this.onRemove,
    required this.onMinus,
    required this.onAddToFavorites,
  });

  @override
  Widget build(BuildContext context) {
    // Вспомогательный метод для отображения иконки поставщика или первой буквы
    return Card(
      // margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      elevation: 0, // Убираем тень, как на скриншоте
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Column(
        children: [
          // Средняя часть: Изображение, название и описание
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: AppImageContainer(image: product.imageUrl),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name ?? 'Название не указано',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      if (product.propertyName != null &&
                          product.propertyName!.isNotEmpty)
                        Text(
                          product.propertyName!,
                          style: const TextStyle(
                            fontSize: 13,
                            color: Colors.grey,
                          ),
                        ),
                      SizedBox(height: 16),
                      // Нижняя часть: Управление количеством и действия
                      FittedBox(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              '${product.price?.toStringAsFixed(0) ?? '0'} c',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                              ),
                            ),
                            SizedBox(width: 8),
                            // Кнопки количества
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: ServiceColors.primaryColor,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                children: [
                                  IconButton(
                                    icon: const Icon(
                                      Icons.remove_circle_outline,
                                      color: ServiceColors.primaryColor,
                                      size: 30,
                                    ),
                                    onPressed: onMinus,
                                    constraints: const BoxConstraints(),
                                    padding: const EdgeInsets.all(8),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                    ),
                                    child: Text(
                                      product.quantity.toString(),
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(
                                      Icons.add_circle_outline,
                                      color: ServiceColors.primaryColor,
                                      size: 30,
                                    ),
                                    onPressed: onAdd,
                                    constraints: const BoxConstraints(),
                                    padding: const EdgeInsets.all(8),
                                  ),
                                ],
                              ),
                            ),
                            // Кнопки избранного и удаления
                            Row(
                              children: [
                                IconButton(
                                  icon: Icon(
                                    product.liked
                                        ? CupertinoIcons.heart_fill
                                        : CupertinoIcons.heart,
                                    color: product.liked
                                        ? Colors.red
                                        : Colors
                                              .grey, // changes color when liked
                                    size: 30,
                                  ),
                                  onPressed: onAddToFavorites,
                                ),
                                IconButton(
                                  icon: const Icon(
                                    Icons.delete_outline_rounded,
                                    color: ServiceColors.primaryColor,
                                  ),
                                  onPressed: onRemove,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
