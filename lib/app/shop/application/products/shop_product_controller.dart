import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:service_shop/app/shop/domain/repositories/i_shop_repository.dart';
import 'package:service_shop/core/enum/state_type.dart';
import 'package:service_shop/injection.dart';
import 'shop_product_state.dart';

final shopProductProvider = StateNotifierProvider<ShopProductController, ShopProductState>((ref) {
  return ShopProductController(getIt<IShopRepository>());
});

class ShopProductController extends StateNotifier<ShopProductState> {
  ShopProductController(this._api) : super(const ShopProductState());

  final IShopRepository _api;

  Future<void> loadShopProducts(String shopUuid) async {
    state = state.copyWith(status: StateType.loading, error: null);
    try {
      await Future.delayed(const Duration(seconds: 1));
      final categories = await _api.getShopProducts(shopUuid);
      state = state.copyWith(categories: categories, status: StateType.loaded);
    } catch (e) {
      state = state.copyWith(status: StateType.error, error: e.toString());
    }
  }
}

