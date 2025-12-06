import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:service_shop/app/shop/application/shops/shops_controller.dart';
import 'package:service_shop/app/shop/application/shops/shops_state.dart';
import 'package:service_shop/app/shop/domain/repositories/i_shop_repository.dart';
import 'package:service_shop/injection.dart';

final shopsProvider = StateNotifierProvider<ShopsController, ShopsState>((ref) {
  return ShopsController(getIt<IShopRepository>());
});
