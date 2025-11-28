import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:service_shop/app/shop/domain/repositories/i_shop_repository.dart';
import 'shops_state.dart';

class ShopsController extends StateNotifier<ShopsState> {
  final IShopRepository repository;
  ShopsController(this.repository) : super(const ShopsState());

  Future<void> toggleFavorite(String shopUuid) async {
    final currentShops = state.shops;
    final shopIndex = currentShops.indexWhere((shop) => shop.id == shopUuid);
    if (shopIndex == -1) return;

    final isLiked = currentShops[shopIndex].liked;
    try {
      if (isLiked) {
        final result = await repository.unlikeShop(shopUuid);

        if (result) {
          final updatedShop = currentShops[shopIndex].copyWith(liked: !isLiked);
          final updatedShops = List.of(currentShops);
          updatedShops[shopIndex] = updatedShop;
          state = state.copyWith(shops: updatedShops);
        }
      } else {
        final result = await repository.likeShop(shopUuid);
        if (result) {
          final updatedShop = currentShops[shopIndex].copyWith(liked: !isLiked);
          final updatedShops = List.of(currentShops);
          updatedShops[shopIndex] = updatedShop;
          state = state.copyWith(shops: updatedShops);
        }
      }
    } catch (e) {
      // Handle error if needed
    }
  }

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
