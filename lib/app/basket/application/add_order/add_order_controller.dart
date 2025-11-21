import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:service_shop/app/basket/application/add_order/add_order_state.dart';
import 'package:service_shop/app/basket/application/basket_provider/basket_state.dart';
import 'package:service_shop/app/basket/application/checkout_provider/checkout_state.dart';
import 'package:service_shop/app/basket/domain/repositories/i_basket_repository.dart';
import 'package:service_shop/core/enum/state_type.dart';
import 'package:service_shop/injection.dart';

///[addOrderProvider] -- Provider for managing the state of product detail loading
/// using Riverpod's StateNotifierProvider.
final addOrderProvider =
    StateNotifierProvider<AddOrderController, AddOrderState>((ref) {
      return AddOrderController(getIt<IBasketRepository>());
    });

/// [AddOrderController] -- Controller class that extends StateNotifier
/// to manage the state of product detail loading.
class AddOrderController extends StateNotifier<AddOrderState> {
  AddOrderController(this._api) : super(AddOrderState.initial());

  final IBasketRepository _api;

  Future<void> post(CheckoutState basketState) async {
    state = state.copyWith(status: StateType.loading);
    final result = await _api.addOrder(basketState.toJson());
    if (result) {
      state = state.copyWith(status: StateType.loaded);
    } else {
      state = state.copyWith(status: StateType.error);
    }
    await Future.delayed(const Duration(seconds: 2));
    state = state.copyWith(status: StateType.initial);
  }
}
