import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:service_shop/app/basket/application/basket_provider/basket_controller.dart';
import 'package:service_shop/app/basket/presentation/basket_product_item_widget.dart';
import 'package:service_shop/app/basket/presentation/section/address_section.dart';
import 'package:service_shop/app/basket/presentation/section/delivery_section.dart';
import 'package:service_shop/app/basket/presentation/section/total_price_section.dart';
import 'package:service_shop/app/basket/presentation/widgets/confirm_button.dart';
import 'package:service_shop/app/basket/presentation/widgets/payment_method_widget.dart';
import 'package:service_shop/core/presentation/appbar/favs_app_bar.dart';

class CheckoutScreen extends ConsumerWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final basketState = ref.watch(basketProvider);
    final products = basketState.shopItems;
    return SafeArea(
      child: SafeArea(
        child: Scaffold(
          appBar: FavsAppBar(title: "Оформление заказа"),
          body: SingleChildScrollView(
            padding: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...products.map((shopItem) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        leading: CircleAvatar(radius: 15),
                        title: Text(
                          shopItem.shop.name,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                      ListView.separated(
                        separatorBuilder: (_, __) => Divider(),
                        itemCount: shopItem.products.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final product = shopItem.products[index];
                          return BasketProductCard(
                            onMinus: () {
                              ref
                                  .read(basketProvider.notifier)
                                  .onMinusCount(product, shopItem.shop.id);
                            },
                            onAddToFavorites: () {
                              ref
                                  .read(basketProvider.notifier)
                                  .onLike(product, shopItem.shop.id);
                            },
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
                }),
                DeliverySection(),
                SizedBox(height: 20),
                TotalPriceSection(),
                AddressSection(),
                Divider(),
                PaymentMethodsWidget(),
                SizedBox(height: 16),
                ConfirmButton(totalPrice: 1245, onConfirm: () {}),
                SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
