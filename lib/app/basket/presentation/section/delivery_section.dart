import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:service_shop/app/basket/application/basket_provider/basket_controller.dart';
import 'package:service_shop/core/enum/delivery_type.dart';
import 'package:service_shop/core/presentation/theme/colors.dart';

class DeliverySection extends ConsumerWidget {
  const DeliverySection({super.key, required this.onDeliveryTypeChanged});

  final Function(String deliveryType, String shopId, double cost) onDeliveryTypeChanged;


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
                final isSelected = false;
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
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Radio<int>(
                            value: deliveryIndex,
                            groupValue: 1, // replace with selected index
                            onChanged: (value) {
                              ///TODO: Не работает переключение.
                              ///Сделай отдельный стейтфул виджет для чекбоксов.
                              onDeliveryTypeChanged(
                                  delivery.type, shop.id, delivery.cost);
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
                                Text(
                                  'Стоимость: ${delivery.cost}',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
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
