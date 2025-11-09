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
    return SafeArea(
      child: Scaffold(
          appBar: FavsAppBar(
            title: "Оформление заказа",
          ),
          body: Consumer(builder: (context, ref, child) {
            final checkoutState = ref.watch(checkoutProvider); // Здесь должен быть ваш провайдер состояния корзины
            final products = checkoutState.shopItems;
            return ListView.builder(
              itemCount: products.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final shopItem = products[index];
                return Column(
                  children: [
                    ListTile(
                      title: Text('Магазин ${shopItem.shopName}'),
                      trailing: Text(shopItem.totalAmount.toString()),
                    ),
                    ListView.separated(
                      separatorBuilder: (context, index) => Divider(),
                      itemCount: products.elementAt(index).products.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final product = shopItem.products.elementAt(index);
                        return BasketProductCard(
                          onMinus: () {
                            ref.read(checkoutProvider.notifier).onMinusCount(product, shopItem.shopId);
                          },
                          onAddToFavorites: () {
                            ref.read(checkoutProvider.notifier).onLike(product, shopItem.shopId);
                          },
                          onAdd: () {
                            ref.read(checkoutProvider.notifier).onAddCount(product, shopItem.shopId);
                          },
                          onRemove: () {
                            ref.read(checkoutProvider.notifier).remove(product, shopItem.shopId);
                          },
                          product:product ,
                        );
                      },),

                    /// delivere
                    SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Доставка:', style: Theme.of(context).textTheme.bodyMedium),
                          Text(shopItem.deliveryType.toString(), style: Theme.of(context).textTheme.bodyMedium),
                        ],
                      ),
                    ),
                    SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Способ оплаты:', style: Theme.of(context).textTheme.bodyMedium),
                          Text(checkoutState.paymentType.toString(), style: Theme.of(context).textTheme.bodyMedium),
                          //Text(.toString(), style: Theme.of(context).textTheme.bodyMedium),
                        ],
                      ),
                    ),

                    /// Кнопка перейти к оформлению заказа всем магазинам.
                    SizedBox(height: 16),
                    // CustomButton(
                    //   width: MediaQuery.of(context).size.width * 0.9,
                    //   text: "Перейти к оформлению заказа",onPressed: () {
                    //
                    // },),



                  ],
                );

              },);
          },)
      ),
    );
  }
}
