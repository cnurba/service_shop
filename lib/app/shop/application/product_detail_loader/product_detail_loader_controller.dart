import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:service_shop/app/core/models/data_tree.dart';
import 'package:service_shop/app/shop/application/product_detail_loader/product_detail_loader_state.dart';
import 'package:service_shop/app/shop/domain/repositories/i_shop_repository.dart';
import 'package:service_shop/core/enum/state_type.dart';
import 'package:service_shop/injection.dart';

///[productDetailLoaderProvider] -- Provider for managing the state of product detail loading
/// using Riverpod's StateNotifierProvider.
final productDetailLoaderProvider = StateNotifierProvider<
    ProductDetailLoaderController, ProductDetailLoaderState>((ref) {
  return ProductDetailLoaderController(getIt<IShopRepository>());
});

/// [ProductDetailLoaderController] -- Controller class that extends StateNotifier
/// to manage the state of product detail loading.
class ProductDetailLoaderController
    extends StateNotifier<ProductDetailLoaderState> {
  ProductDetailLoaderController(this._api)
    : super(ProductDetailLoaderState.initial());

  final IShopRepository _api;

  Future<void> load(String shopUuid, String productUuid) async {
    state = state.copyWith(status: StateType.loading);
    final DataTree result = await _api.getProductDetail(
      shopUuid: shopUuid,
      productUuid: productUuid,
    );
    state = state.copyWith(status: StateType.loaded, dataTree: result);
  }
}
