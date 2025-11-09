import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:service_shop/app/basket/application/basket_provider/basket_controller.dart';
import 'package:service_shop/app/basket/application/checkout_provider/checkout_controller.dart';
import 'package:service_shop/app/basket/presentation/basket_product_item_widget.dart';
import 'package:service_shop/app/basket/presentation/empty_basket_widget.dart';
import 'package:service_shop/core/presentation/appbar/favs_app_bar.dart';
import 'package:service_shop/core/presentation/buttons/custom_button.dart';

class CheckoutScreen extends ConsumerWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final basketState = ref.watch(basketProvider);
    final products = basketState.shopItems;
    final shops = products.map((e) => e.shop).toList();

    return SafeArea(
      child: Scaffold(
        appBar: FavsAppBar(
          title: "Оформление заказа",
        ),
        body: Column(
          children: [
            ListView.builder(
              itemCount: products.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final shopItem = products[index];
                return Column(
                  children: [
                    ListTile(
                      title: Text('Магазин ${shopItem.shop.name}'),
                      trailing: Text(shopItem.totalAmount.toString()),
                    ),
                    ListView.separated(
                      separatorBuilder: (context, index) => Divider(),
                      itemCount: products
                          .elementAt(index)
                          .products
                          .length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final product = shopItem.products.elementAt(index);
                        return BasketProductCard(
                          onMinus: () {
                            ref.read(basketProvider.notifier).onMinusCount(
                                product, shopItem.shop.id);
                          },
                          onAddToFavorites: () {
                            ref.read(basketProvider.notifier).onLike(
                                product, shopItem.shop.id);
                          },
                          onAdd: () {
                            ref.read(basketProvider.notifier).onAddCount(
                                product, shopItem.shop.id);
                          },
                          onRemove: () {
                            ref.read(basketProvider.notifier).remove(
                                product, shopItem.shop.id);
                          },
                          product: product,
                        );
                      },),

                    ListView.builder(
                      itemCount: shops.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final shop = shops[index];
                        return Column(
                          children: [
                            Text(shops[index].name),
                            GridView.builder(
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 3,
                              ),
                              shrinkWrap: true,
                              itemCount: shop.deliveries.length, // Пример количества способов доставки
                              itemBuilder: (context, deliveryIndex) {
                                final delivery = shop.deliveries[deliveryIndex];
                                return ListTile(
                                  title: Text(delivery.type),
                                  subtitle: Text('Стоимость: ${delivery.cost}'),
                                  leading: Radio(
                                    value: deliveryIndex,
                                    groupValue: 0, // Здесь должна быть выбранная доставка
                                    onChanged: (value) {
                                      // Логика выбора способа доставки
                                    },
                                  ),
                                );
                              },
                            ),

                          ],
                        );
                      },)

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

                    /// Кнопка перейти к оформлению заказа всем магазинам.
                   // SizedBox(height: 16),
                    // CustomButton(
                    //   width: MediaQuery.of(context).size.width * 0.9,
                    //   text: "Перейти к оформлению заказа",onPressed: () {
                    //
                    // },),


                  ],
                );
              },),
          ],
        ),
      ),
    );
  }
}
