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
        appBar: FavsAppBar(
          title: "Корзина",
        ),
        body: Consumer(builder: (context, ref, child) {
            final productsInBasketState = ref.watch(basketProvider); // Здесь должен быть ваш провайдер состояния корзины
            final productsInBasket = productsInBasketState.shopItems;
            if(productsInBasket.isEmpty){
              return ListView(

                children: const [
                  /// Виджет показывает у вас еще нет избранных товаров
                  EmptyBasketWidget(),
                ],
              );
            }else{
              // TODO: реализовать отображение содержимого корзины
              // Показать: список магазинов, товары в магазине, сумма и кнопка оформления
              //final totalAll = productsInBasket.fold<double>(0.0, (prev, element) => prev + (element.totalAmount));

              return ListView.builder(
                itemCount: productsInBasket.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final shopItem = productsInBasket[index];
                  return Column(
                    children: [
                      ListTile(
                        title: Text('Магазин ${shopItem.shop.name}'),
                        trailing: Text(shopItem.totalAmount.toString()),
                      ),
                      ListView.separated(
                        separatorBuilder: (context, index) => Divider(),
                        itemCount: productsInBasket.elementAt(index).products.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          final product = shopItem.products.elementAt(index);
                          return BasketProductCard(
                            onMinus: () {
                              ref.read(basketProvider.notifier).onMinusCount(product, shopItem.shop.id);
                            },
                            onAddToFavorites: () {
                              ref.read(basketProvider.notifier).onLike(product, shopItem.shop.id);
                            },
                            onAdd: () {
                              ref.read(basketProvider.notifier).onAddCount(product, shopItem.shop.id);
                            },
                            onRemove: () {
                              ref.read(basketProvider.notifier).remove(product, shopItem.shop.id);
                            },
                            product:product ,
                          );
                        },), 

                      /// Кнопка перейти к оформлению заказа всем магазинам.
                      SizedBox(height: 16),
                      CustomButton(
                        width: MediaQuery.of(context).size.width * 0.9,
                        text: "Перейти к оформлению заказа",onPressed: () {
                          ref.read(checkoutProvider.notifier).initialize(productsInBasketState);

                          context.push(CheckoutScreen()); 
                        },),

                    ],
                  );

                },);
            }

          },)
      ),
    );
  }
}
