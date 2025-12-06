import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:service_shop/app/basket/domain/repositories/i_basket_repository.dart';
import 'package:service_shop/app/basket/infrastructure/repositories/basket_repository.dart';
import 'package:service_shop/app/profile/domain/repositories/i_profile_repository.dart';
import 'package:service_shop/app/profile/infrastructure/repositories/profile_repository.dart';
import 'package:service_shop/app/search/domain/repository/i_search_repository.dart';
import 'package:service_shop/app/search/infrastructure/repositories/search_repository.dart';
import 'package:service_shop/app/shop/domain/repositories/i_shop_repository.dart';
import 'package:service_shop/app/shop/infrastructure/repositories/shop_repository.dart';
import 'package:service_shop/auth/domain/repositories/i_auth_repository.dart';
import 'package:service_shop/auth/infrastructure/repositories/auth_repository.dart';
import 'package:service_shop/core/http/dio_interceptor.dart';
import 'auth/domain/repositories/i_token_storage.dart';
import 'auth/infrastructure/repositories/token_storage.dart';

/// The instance of [GetIt]
final GetIt getIt = GetIt.instance;

void initGetIt() {
  getIt.registerLazySingleton<FlutterSecureStorage>(
    () => const FlutterSecureStorage(),
  );

  getIt.registerLazySingleton<ITokenStorage>(() => TokenStorage(getIt()));
  getIt.registerLazySingleton<Dio>(() => Dio());
  getIt.registerLazySingleton<DioInterceptor>(
    () => DioInterceptor(getIt(), getIt()),
  );
  getIt.registerLazySingleton<IAuthRepository>(
    () => AuthRepository(getIt(), getIt()),
  );
  getIt.registerLazySingleton<IShopRepository>(() => ShopRepository(getIt()));
  getIt.registerLazySingleton<ISearchRepository>(
    () => SearchRepository(getIt()),
  );

  getIt.registerLazySingleton<IBasketRepository>(
    () => BasketRepository(getIt()),
  );
  getIt.registerLazySingleton<IProfileRepository>(
    () => ProfileRepository(getIt(), getIt()),
  );
}
