import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:service_shop/app/basket/application/basket_provider/basket_controller.dart';
import 'package:service_shop/core/presentation/theme/colors.dart';

final selectedDeliveryProvider = StateProvider.family<int, String>(
  (ref, shopId) => -1,
);

class DeliverySection extends ConsumerWidget {
  const DeliverySection({super.key, required this.onDeliveryTypeChanged});

  final Function(String deliveryType, String shopId, double cost)
  onDeliveryTypeChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final basketState = ref.watch(basketProvider);
    final products = basketState.shopItems;
    final shops = products.map((e) => e.shop).toList();
    return ListView.builder(
      itemCount: shops.length,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        final shop = shops[index];
        final selectedDelivery = ref.watch(selectedDeliveryProvider(shop.id));
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Способ доставки', style: TextTheme.of(context).titleMedium!),
            SizedBox(height: 6),
            ListTile(
              leading: CircleAvatar(radius: 15),
              title: Text(
                shops[index].name,
                style: TextTheme.of(context).titleSmall,
              ),
            ),
            SizedBox(height: 6),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                childAspectRatio: 2.8,
              ),
              itemCount: shop.deliveries.length,
              itemBuilder: (context, deliveryIndex) {
                final delivery = shop.deliveries[deliveryIndex];
                final isSelected = selectedDelivery == deliveryIndex;
                return Container(
                  decoration: BoxDecoration(
                    color: ServiceColors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isSelected
                          ? ServiceColors.primaryColor
                          : Colors.grey.shade300,
                      width: 1.5,
                    ),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      ref
                              .read(selectedDeliveryProvider(shop.id).notifier)
                              .state =
                          deliveryIndex;
                      onDeliveryTypeChanged(
                        delivery.type,
                        shop.id,
                        delivery.cost,
                      );
                    },
                    // borderRadius: BorderRadius.circular(12),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Radio<int>(
                            value: deliveryIndex,
                            groupValue:
                                selectedDelivery, // replace with selected index
                            onChanged: (value) {
                              if (value != null) {
                                ref
                                        .read(
                                          selectedDeliveryProvider(
                                            shop.id,
                                          ).notifier,
                                        )
                                        .state =
                                    value;

                                onDeliveryTypeChanged(
                                  delivery.type,
                                  shop.id,
                                  delivery.cost,
                                );
                              }
                            },
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  delivery.type,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                if (delivery.cost > 0)
                                  Row(
                                    children: [
                                      Icon(CupertinoIcons.creditcard),
                                      SizedBox(width: 8),
                                      Text(
                                        '${delivery.cost}',
                                        style: const TextStyle(
                                          fontSize: 12,
                                          // color: Colors.red,
                                        ),
                                      ),
                                    ],
                                  )
                                else
                                  const SizedBox.shrink(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
