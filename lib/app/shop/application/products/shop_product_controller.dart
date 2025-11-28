import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:service_shop/app/core/models/products/product.dart';
import 'package:service_shop/app/shop/domain/repositories/i_shop_repository.dart';
import 'package:service_shop/core/enum/state_type.dart';
import 'package:service_shop/injection.dart';
import 'shop_product_state.dart';

final shopProductProvider =
    StateNotifierProvider<ShopProductController, ShopProductState>((ref) {
      return ShopProductController(getIt<IShopRepository>());
    });

/// Provider that returns all liked products from all categories
// final favouriteProductsProvider = Provider<List<Product>>((ref) {
//   final state = ref.watch(shopProductProvider);
//   return state.categories
//       .expand((cat) => cat.products)
//       .where((product) => product.liked)
//       .toList();
// });

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

  Future<void> toggleFavorite(
    String uuid, {
    required int categoryIndex,
    required int productIndex,
    required Product product,
  }) async {
    final currentCategories = state.categories;

    if (categoryIndex < 0 || categoryIndex >= currentCategories.length) return;
    if (productIndex < 0 ||
        productIndex >= currentCategories[categoryIndex].products.length)
      return;

    final isLiked = product.liked;

    try {
      if (isLiked) {
        final result = await _api.unlikeProduct(
          product.propertyUuid,
          product.branchUuid,
        );
        if (result) {
          final updatedProduct = product.copyWith(liked: !isLiked);
          final updatedProducts = List.of(
            currentCategories[categoryIndex].products,
          );
          updatedProducts[productIndex] = updatedProduct;

          final updatedCategory = currentCategories[categoryIndex];
          final updatedCategories = List.of(currentCategories);
          updatedCategories[categoryIndex] = updatedCategory.copyWith(
            products: updatedProducts,
          );

          state = state.copyWith(categories: updatedCategories);
        }
      } else {
        final result = await _api.likeProduct(
          product.propertyUuid,
          product.branchUuid,
        );
        if (result) {
          final updatedProduct = product.copyWith(liked: !isLiked);
          final updatedProducts = List.of(
            currentCategories[categoryIndex].products,
          );
          updatedProducts[productIndex] = updatedProduct;

          final updatedCategory = currentCategories[categoryIndex];
          final updatedCategories = List.of(currentCategories);
          updatedCategories[categoryIndex] = updatedCategory.copyWith(
            products: updatedProducts,
          );

          state = state.copyWith(categories: updatedCategories);
        }
      }
    } catch (e) {
      // Handle error if needed
    }
  }
}
