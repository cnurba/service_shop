import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:service_shop/app/search/application/product_search/product_search_state.dart';
import 'package:service_shop/app/shop/domain/repositories/i_shop_repository.dart';
import 'package:service_shop/core/enum/state_type.dart';
import 'package:service_shop/injection.dart';


final productSearchProvider =
    StateNotifierProvider<ProductSearchController, ProductSearchState>((ref) {
      return ProductSearchController(getIt<IShopRepository>());
    });

class ProductSearchController extends StateNotifier<ProductSearchState> {
  ProductSearchController(this._api) : super(ProductSearchState.initial());

  final IShopRepository _api;

  Future<void> loadProducts(Map<String, dynamic> queryParams) async {
    state = state.copyWith(status: StateType.loading, error: null);
    try {
      await Future.delayed(const Duration(seconds: 1));
      final products = await _api.searchProducts(queryParams: queryParams);
      state = state.copyWith(products: products, status: StateType.loaded);
    } catch (e) {
      state = state.copyWith(status: StateType.error, error: e.toString());
    }
  }

}
