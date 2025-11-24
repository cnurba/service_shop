import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:service_shop/app/basket/application/basket_provider/basket_controller.dart';
import 'package:service_shop/core/presentation/theme/colors.dart';

/// Provider to track selected delivery index for each shop (by shop index)
final selectedDeliveryProvider = StateProvider.family<int, int>(
  (ref, shopIndex) => 0,
);

class DeliverySection extends ConsumerWidget {
  const DeliverySection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final basketState = ref.watch(basketProvider);
    final products = basketState.shopItems;
    final shops = products.map((e) => e.shop).toList();
    return ListView.builder(
      itemCount: shops.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        final shop = shops[index];
        final selectedDelivery = ref.watch(selectedDeliveryProvider(index));
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
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () {
                      ref.read(selectedDeliveryProvider(index).notifier).state =
                          deliveryIndex;
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Radio<int>(
                            value: deliveryIndex,
                            groupValue: selectedDelivery,
                            onChanged: (value) {
                              if (value != null) {
                                ref
                                        .read(
                                          selectedDeliveryProvider(
                                            index,
                                          ).notifier,
                                        )
                                        .state =
                                    value;
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

            /// delivere
            // SizedBox(height: 8),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 16.0),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       Text('Доставка:', style: Theme.of(context).textTheme.bodyMedium),
            //       Text(shopItem.deliveryType.toString(), style: Theme.of(context).textTheme.bodyMedium),
            //     ],
            //   ),
            // ),
            // SizedBox(height: 8),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 16.0),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       Text('Способ оплаты:', style: Theme.of(context).textTheme.bodyMedium),
            //       Text(checkoutState.paymentType.toString(), style: Theme.of(context).textTheme.bodyMedium),
            //       //Text(.toString(), style: Theme.of(context).textTheme.bodyMedium),
            //     ],
            //   ),
            // ),
            // const Divider(),
          ],
        );
      },
    );
  }
}
