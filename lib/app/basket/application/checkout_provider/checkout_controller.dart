import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:service_shop/app/basket/application/basket_provider/basket_state.dart';
import 'package:service_shop/app/basket/application/checkout_provider/checkout_state.dart';
import 'package:service_shop/app/core/models/products/product.dart';

final checkoutProvider =
    StateNotifierProvider<CheckoutController, CheckoutState>((ref) {
      return CheckoutController();
    });

class CheckoutController extends StateNotifier<CheckoutState> {
  CheckoutController() : super(CheckoutState.initial());

  void initialize(BasketState basketState) {
    state = state.copyWith(
      deliveryCost: 0,
      finalAmount: basketState.totalAmount,
      totalAmount: basketState.totalAmount,
      totalCount: basketState.totalCount,
      totalShops: basketState.shopItems.length,
    );
  }

  void onChangeName(String name) {
    state = state.copyWith(name: name);
  }

  void onChangePhone(String phone) {
    state = state.copyWith(phone: phone);
  }

  void onChangeCity(String city) {
    state = state.copyWith(city: city);
  }

  void onChangeStreet(String street) {
    state = state.copyWith(street: street);
  }

  void onChangeApartment(String apartment) {
    state = state.copyWith(apartment: apartment);
  }

  void onChangeSaveInfo(bool saveInfo) {
    state = state.copyWith(saveInfo: saveInfo);
  }

  void changePaymentType(String paymentType) {
    state = state.copyWith(paymentType: paymentType);
  }

  void fillShopItems(BasketState basketState) {
    state = state.copyWith(shopItems: basketState.shopItems);

    print(state.toJson());

  }

  void setDeliveryCost(double cost) {
    state = state.copyWith(
      deliveryCost: state.deliveryCost + cost,
      finalAmount: state.totalAmount + cost,
    );
  }


  void onLike(Product product, String shopId) {}
}
