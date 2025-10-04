import 'package:flutter/material.dart';
import 'package:service_shop/app/shop/domain/models/shop.dart';
import 'package:service_shop/core/presentation/image/app_image_container.dart';

class ShopCard extends StatelessWidget {
  final Shop shop;
  final VoidCallback? onFavorite;
  final bool isFavorite;

  const ShopCard({
    super.key,
    required this.shop,
    this.onFavorite,
    this.isFavorite = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
            child: AppImageContainer(
              image: shop.imageUrl,
              height: 120,
              width: double.infinity,
              fit: BoxFit.cover,

            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        shop.name,
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: Colors.red,
                      ),
                      onPressed: onFavorite,
                    ),
                  ],
                ),
                if (shop.description.isNotEmpty)
                  Text(
                    shop.description,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                const SizedBox(height: 4),
                Text(
                  shop.address,
                  style: Theme.of(context).textTheme.bodySmall,
                  maxLines: 2,
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      shop.isOpen ? 'Открыто:' : 'Закрыто:',
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: shop.isOpen ? Colors.green : Colors.red,
                      ),
                    ),
                    const SizedBox(width: 2),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 4,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: shop.isOpen
                            ? Colors.green[100]
                            : Colors.red[100],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        shop.workingHours,
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: shop.isOpen ? Colors.green : Colors.red,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 18),
                    const SizedBox(width: 4),
                    Text(
                      shop.rating.toStringAsFixed(1),
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                    const SizedBox(width: 4),
                    if (shop.rating > 0)
                      Text(
                        'оценок',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                  ],
                ),
                // if (shop.phone.isNotEmpty)
                //   Padding(
                //     padding: const EdgeInsets.only(top: 4),
                //     child: Text(
                //       'Тел.: ${shop.phone}',
                //       style: const TextStyle(fontSize: 13),
                //     ),
                //   ),
                // if (shop.discountPercent > 0)
                //   Padding(
                //     padding: const EdgeInsets.only(top: 4),
                //     child: Text(
                //       'Скидка: ${shop.discountPercent}%',
                //       style: const TextStyle(
                //         color: Colors.red,
                //         fontWeight: FontWeight.bold,
                //       ),
                //     ),
                //   ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
