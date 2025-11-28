import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:service_shop/app/core/models/products/product.dart';
import 'package:service_shop/app/favs/application/favorites_product_state.dart';
import 'package:service_shop/app/shop/domain/repositories/i_shop_repository.dart';
import 'package:service_shop/core/enum/state_type.dart';

class FavoritesProductController extends StateNotifier<FavoritesProductState> {
  final IShopRepository repository;

  FavoritesProductController(this.repository)
    : super(FavoritesProductState.initial());

  Future<void> getLikes() async {
    try {
      final likes = await repository.getFavoriteProduct();
      state = state.copyWith(favoriteProducts: likes);
    } catch (e) {
      state = state.copyWith(status: StateType.error);
    }
  }

  Future<bool> unLikes(Product product) async {
    final isLiked = product.liked;

    try {
      // If product is not liked → nothing to remove
      if (!isLiked) {
        return false;
      }

      // Call API to remove from favorites
      final result = await repository.unlikeProduct(
        product.propertyUuid,
        product.branchUuid,
      );

      // result == true → success
      if (result) {
        // Update state if needed
        getLikes();
        return true;
      }

      // result == false → failed
      return false;
    } catch (e) {
      state = state.copyWith(status: StateType.error);
      return false;
    }
  }
}
