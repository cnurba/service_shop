import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:service_shop/app/basket/application/add_order/add_order_controller.dart';
import 'package:service_shop/app/basket/application/basket_provider/basket_controller.dart';
import 'package:service_shop/app/basket/application/checkout_provider/checkout_controller.dart';
import 'package:service_shop/app/basket/presentation/basket_product_item_widget.dart';
import 'package:service_shop/app/basket/presentation/section/address_storage.dart';
import 'package:service_shop/app/basket/presentation/section/delivery_section.dart';
import 'package:service_shop/app/basket/presentation/section/total_price_section.dart';
import 'package:service_shop/app/basket/presentation/widgets/confirm_button.dart';
import 'package:service_shop/app/basket/presentation/widgets/payment_method_widget.dart';
import 'package:service_shop/app/profile/domain/models/my_address.dart';
import 'package:service_shop/app/profile/presentation/screens/address/my_adress_screen.dart';
import 'package:service_shop/core/enum/state_type.dart';
import 'package:service_shop/core/presentation/appbar/favs_app_bar.dart';
import 'package:service_shop/core/presentation/theme/colors.dart';

class CheckoutScreen extends ConsumerStatefulWidget {
  const CheckoutScreen({super.key});

  @override
  ConsumerState<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends ConsumerState<CheckoutScreen> {
  MyAddressModel? _selectedAddress; 

  @override
  Widget build(BuildContext context) {
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
                            quantity: ref
                                .watch(basketProvider)
                                .getProductCount(product, product.branchUuid),

                            onMinus: () {
                              ref
                                  .read(basketProvider.notifier)
                                  .onMinusCount(product, shopItem.shop.id);
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
                }),
                DeliverySection(
                  onDeliveryTypeChanged: (deliveryType, shopId, cost) {
                    ref
                        .read(basketProvider.notifier)
                        .setDeliveryType(deliveryType, shopId, cost);
                  },
                ),
                SizedBox(height: 20),
                TotalPriceSection(
                  totalShops: products.length,
                  totalCount: basketState.totalCount,
                  totalAmount: basketState.totalAmount,
                  discount: 0,
                  deliveryCost: basketState.totalDeliveryCost,
                  finalAmount: basketState.finishAmount,
                ),
                InkWell(
                  onTap: () async {
                    final selectedAddress = await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => MyAddressesScreen()),
                    );

                    if (selectedAddress != null) {
                      setState(() {
                        _selectedAddress = selectedAddress;
                      });

                      // update checkout provider with new address data
                      final checkout = ref.read(checkoutProvider.notifier);
                      checkout.onChangeName(selectedAddress.name);
                      checkout.onChangePhone(selectedAddress.phone);
                      checkout.onChangeCity(selectedAddress.city);
                      checkout.onChangeStreet(selectedAddress.street);
                      checkout.onChangeApartment(selectedAddress.apartment);
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: ServiceColors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text("Выберите адрес"),
                  ),
                ),
                if (_selectedAddress != null) ...[
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Имя: ${_selectedAddress!.name}"),
                        Text("Номер: ${_selectedAddress!.phone}"),
                        Text("Город: ${_selectedAddress!.city}"),
                        Text("Улица: ${_selectedAddress!.street}"),
                        Text("Квартира: ${_selectedAddress!.apartment}"),
                      ],
                    ),
                  ),
                ],
                Divider(),
                PaymentMethodsWidget(
                  onPaymentMethodChanged: (paymentType) {
                    ref
                        .read(checkoutProvider.notifier)
                        .changePaymentType(paymentType);
                  },
                ),
                SizedBox(height: 16),
                ConfirmButton(
                  totalPrice: checkoutState.finalAmount,
                  // onConfirm: () {
                  //   // Подтверждение заказа

                  //   ref
                  //       .read(checkoutProvider.notifier)
                  //       .fillShopItems(basketState);
                  //   final checkoutState = ref.watch(checkoutProvider);
                  //   ref.read(addOrderProvider.notifier).post(checkoutState);
                  // },
                  onConfirm: () async {
                    final checkoutState = ref.read(checkoutProvider);

                    // Save address if user checked "Save info"
                    if (checkoutState.saveInfo) {
                      await AddressStorage.saveAddress(
                        name: checkoutState.name,
                        phone: checkoutState.phone,
                        city: checkoutState.city,
                        street: checkoutState.street,
                        apartment: checkoutState.apartment,
                        saveInfo: true,
                      );
                    }

                    ref.read(addOrderProvider.notifier).post(checkoutState);
                  },
                ),
                Consumer(
                  builder: (context, ref, child) {
                    final status = ref.watch(addOrderProvider).status;
                    if (status == StateType.loaded) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Заказ успешно создан!')),
                        );
                        ref.read(basketProvider.notifier).clearBasket();
                        Navigator.of(
                          context,
                        ).popUntil((route) => route.isFirst);
                      });
                    } else if (status == StateType.error) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Ошибка при создании заказа. Попробуйте еще раз.',
                            ),
                          ),
                        );
                      });
                    } else if (status == StateType.loading) {
                      return Center(child: CircularProgressIndicator());
                    } else {
                      return SizedBox.shrink();
                    }

                    return SizedBox.shrink();
                  },
                ),

                SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
