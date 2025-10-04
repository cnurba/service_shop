import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:service_shop/app/shop/domain/repositories/i_shop_repository.dart';
import 'shops_state.dart';

class ShopsController extends StateNotifier<ShopsState> {
  final IShopRepository repository;
  ShopsController(this.repository) : super(const ShopsState());

  Future<void> loadShops() async {
    state = state.copyWith(status: ShopsStatus.loading, error: null);
    try {
      final shops = await repository.getShops();
      state = state.copyWith(shops: shops, status: ShopsStatus.loaded);
    } catch (e) {
      state = state.copyWith(status: ShopsStatus.error, error: e.toString());
    }
  }

}
