import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:service_shop/app/shop/domain/models/shop_products.dart';
import 'package:service_shop/app/shop/presentation/widgets/add_remove_button.dart';
import 'package:service_shop/core/presentation/image/app_image_container.dart';
import 'package:service_shop/core/presentation/theme/colors.dart';

class ShopProductDetailCard extends StatefulWidget {
  final ShopProduct product;
  final VoidCallback? onFavorite;
  final int count;
  final VoidCallback? onAdd;
  final VoidCallback? onRemove;
  final VoidCallback? onTap;

  const ShopProductDetailCard({
    super.key,
    required this.product,
    this.onFavorite,
    this.count = 1,
    this.onAdd,
    this.onRemove,
    this.onTap,
  });

  @override
  State<ShopProductDetailCard> createState() => _ShopProductDetailCardState();
}

class _ShopProductDetailCardState extends State<ShopProductDetailCard> {
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
          child: ListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
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
                        CupertinoIcons.heart_fill,
                        color: Colors.red,
                        size: 30,
                      ),
                      onPressed: widget.onFavorite,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${widget.product.price.toString()} с',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                    Text(
                      widget.product.name,
                      style: Theme.of(context).textTheme.bodySmall,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              AddRemoveButton(count: 1, onAdd: () {}, onRemove: () {}),
            ],
          ),
        ),
      ),
    );
  }
}
