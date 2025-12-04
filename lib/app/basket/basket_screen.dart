import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:service_shop/app/basket/application/basket_provider/basket_controller.dart';
import 'package:service_shop/app/basket/application/checkout_provider/checkout_controller.dart';
import 'package:service_shop/app/basket/checkout_screen.dart';
import 'package:service_shop/app/basket/presentation/basket_product_item_widget.dart';
import 'package:service_shop/app/basket/presentation/empty_basket_widget.dart';
import 'package:service_shop/core/extansions/router_extension.dart';
import 'package:service_shop/core/presentation/appbar/favs_app_bar.dart';
import 'package:service_shop/core/presentation/buttons/custom_button.dart';

class BasketScreen extends ConsumerWidget {
  const BasketScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Scaffold(
        appBar: FavsAppBar(title: "Корзина"),
        body: Consumer(
          builder: (context, ref, child) {
            final productsInBasketState = ref.watch(basketProvider);
            final productsInBasket = productsInBasketState.shopItems;

            if (productsInBasket.isEmpty) {
              return const EmptyBasketWidget();
            } else {
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: productsInBasket.length,
                      itemBuilder: (context, shopIndex) {
                        final shopItem = productsInBasket[shopIndex];
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListTile(
                              title: Text('Магазин ${shopItem.shop.name}'),
                              trailing: Text(
                                '${shopItem.totalAmount % 1 == 0
                                    ? shopItem.totalAmount.toInt().toString()
                                    : shopItem.totalAmount.toStringAsFixed(2)} c',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: shopItem.products.length,
                              separatorBuilder: (_, __) => const Divider(),
                              itemBuilder: (context, productIndex) {
                                final product = shopItem.products[productIndex];

                                return BasketProductCard(
                                  quantity: ref
                                      .watch(basketProvider)
                                      .getProductCount(
                                        product,
                                        product.branchUuid,
                                      ),
                                  onMinus: () {
                                    ref
                                        .read(basketProvider.notifier)
                                        .onMinusCount(
                                          product,
                                          shopItem.shop.id,
                                        );
                                  },
                                  onAddToFavorites: () async {},
                                  onAdd: () {
                                    ref
                                        .read(basketProvider.notifier)
                                        .onAddCount(product, shopItem.shop.id);
                                  },
                                  onRemove: () {
                                    ref
                                        .read(basketProvider.notifier)
                                        .remove(product, shopItem.shop.id);
                                  },
                                  product: product,
                                );
                              },
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: CustomButton(
                      width: MediaQuery.of(context).size.width * 0.9,
                      text: "Перейти к оформлению заказа",
                      onPressed: () {
                        ref
                            .read(checkoutProvider.notifier)
                            .initialize(productsInBasketState);
                        context.push(CheckoutScreen());
                      },
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
