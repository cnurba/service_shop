import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:service_shop/app/basket/application/basket_provider/basket_controller.dart';
import 'package:service_shop/app/basket/application/checkout_provider/checkout_controller.dart';
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
    final checkoutState = ref.watch(checkoutProvider);
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
                DeliverySection(
                  onDeliveryTypeChanged: (deliveryType, shopId, cost) {
                    ref
                        .read(basketProvider.notifier)
                        .setDeliveryType(deliveryType, shopId, cost);
                    ref
                        .read(checkoutProvider.notifier)
                        .setDeliveryCost(cost);
                  },
                ),
                SizedBox(height: 20),
                TotalPriceSection(
                  totalShops: products.length,
                  totalCount: checkoutState.totalCount,
                  totalAmount: checkoutState.totalAmount,
                  discount: 0,
                  deliveryCost: checkoutState.deliveryCost,
                  finalAmount: checkoutState.deliveryCost,
                ),
                AddressSection(
                  onNameChanged: (name) =>
                      ref.read(checkoutProvider.notifier).onChangeName(name),
                  onNamePhone: (phone) =>
                      ref.read(checkoutProvider.notifier).onChangePhone(phone),
                  onCityChanged: (city) =>
                      ref.read(checkoutProvider.notifier).onChangeCity(city),
                  onStreetChanged: (street) => ref
                      .read(checkoutProvider.notifier)
                      .onChangeStreet(street),
                  onApartmentChanged: (apartment) => ref
                      .read(checkoutProvider.notifier)
                      .onChangeApartment(apartment),
                  onSaveInfoChanged: (saveInfo) => ref
                      .read(checkoutProvider.notifier)
                      .onChangeSaveInfo(saveInfo),
                ),
                Divider(),
                PaymentMethodsWidget(onPaymentMethodChanged: (paymentType) {
                  ref.read(checkoutProvider.notifier).changePaymentType(paymentType);
                },),
                SizedBox(height: 16),
                ConfirmButton(totalPrice: checkoutState.finalAmount, onConfirm: () {
                  // Подтверждение заказа

                  ref.read(checkoutProvider.notifier).fillShopItems(basketState);

                },),
                SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
