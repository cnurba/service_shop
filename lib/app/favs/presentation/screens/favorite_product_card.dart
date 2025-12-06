//
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:service_shop/app/core/models/products/product.dart';
import 'package:service_shop/core/presentation/image/app_image_container.dart';
import 'package:service_shop/core/presentation/theme/colors.dart';

class FavoriteProductCard extends StatefulWidget {
  final Product product;
  final VoidCallback? onFavorite;
  final double quantity;
  final VoidCallback? onAdd;
  final VoidCallback? onRemove;
  final VoidCallback? onTap;

  const FavoriteProductCard({
    super.key,
    required this.product,
    this.onFavorite,
    this.onAdd,
    this.onRemove,
    this.onTap,
    this.quantity = 0,
  });

  @override
  State<FavoriteProductCard> createState() => _FavoriteProductCardState();
}

class _FavoriteProductCardState extends State<FavoriteProductCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onTap: widget.onTap,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 2,
        margin: const EdgeInsets.all(8),
        child: Row(
          children: [
            // Product Image
            SizedBox(
              width: 120,
              height: 150,
              child: AppImageContainer(
                image: widget.product.imageUrl,
                width: 120,
                height: 150,
                fit: BoxFit.cover,
              ),
            ),
            // Product Details
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${widget.product.price.toString()} с',
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          widget.product.name,
                          style: Theme.of(context).textTheme.bodySmall,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          widget.product.propertyName,
                          style: Theme.of(
                            context,
                          ).textTheme.bodySmall!.copyWith(fontSize: 8),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Spacer(),
                        IconButton(
                          icon: Icon(
                            CupertinoIcons.delete,
                            color: ServiceColors.primaryColor,
                            size: 24,
                          ),
                          onPressed: widget.onFavorite,
                        ),
                        IconButton(
                          icon: const Icon(
                            CupertinoIcons.shopping_cart,
                            color: ServiceColors.primaryColor,
                            size: 24,
                          ),
                          onPressed: widget.onTap,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // Action Buttons
          ],
        ),
      ),
    );
  }
}
