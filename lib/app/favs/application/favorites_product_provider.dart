import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:service_shop/app/favs/application/favorites_product_controller.dart';
import 'package:service_shop/app/favs/application/favorites_product_state.dart';
import 'package:service_shop/app/shop/domain/repositories/i_shop_repository.dart';
import 'package:service_shop/injection.dart';

final favoritesProductProvider =
    StateNotifierProvider<FavoritesProductController, FavoritesProductState>((
      ref,
    ) {
      return FavoritesProductController(getIt<IShopRepository>());
    });
