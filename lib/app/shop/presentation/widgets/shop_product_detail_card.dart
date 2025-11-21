import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:service_shop/app/core/models/products/product.dart';
import 'package:service_shop/app/shop/presentation/widgets/add_remove_button.dart';
import 'package:service_shop/core/presentation/image/app_image_container.dart';

class ProductCard extends StatefulWidget {
  final Product product;
  final VoidCallback? onFavorite;
  final double quantity;
  final VoidCallback? onAdd;
  final VoidCallback? onRemove;
  final VoidCallback? onTap;

  const ProductCard({
    super.key,
    required this.product,
    this.onFavorite,
    this.onAdd,
    this.onRemove,
    this.onTap,
    this.quantity = 0,
  });

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.6,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 2,
          margin: const EdgeInsets.all(8),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        AppImageContainer(
                          image: widget.product.imageUrl,
                          width: double.infinity,
                          height: 150,
                          fit: BoxFit.cover,
                        ),
                        Positioned(
                          top: 8,
                          right: 8,
                          child: IconButton(
                            icon: Icon(
                              widget.product.liked
                                  ? CupertinoIcons.heart_fill
                                  : CupertinoIcons.heart,
                              color: Colors.red,
                              size: 30,
                            ),
                            onPressed: widget.onFavorite,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      child: Column(
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
                    ),
                  ],
                ),
              ),
              // ...existing code...
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: (widget.onAdd != null && widget.onRemove != null)
                    ? AddRemoveButton(
                        count: widget.quantity,
                        onAdd: widget.onAdd!,
                        onRemove: widget.onRemove!,
                      )
                    : const SizedBox.shrink(),
              ),
              // ...existing code...
            ],
          ),
        ),
      ),
    );
  }
}
