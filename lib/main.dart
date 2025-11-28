import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:service_shop/core/http/server_address.dart';
import 'package:service_shop/injection.dart';
import 'package:service_shop/service_client_app.dart';
import 'core/http/dio_interceptor.dart';

void main() async {
  await _appInitializer();
}

/// Initializes dependencies.
Future<void> _appInitializer() async {
  WidgetsFlutterBinding.ensureInitialized();
  initGetIt();
  getIt<Dio>()
    ..options = BaseOptions(
      connectTimeout: const Duration(milliseconds: 60 * 1000),
      receiveTimeout: const Duration(milliseconds: 60 * 1000),
      baseUrl: ServerAddress().baseUrl,
    )
    ..interceptors.add(getIt<DioInterceptor>());
  //configureInjection(Environment.prod);
  runApp(ProviderScope(child: const ServiceClientApp()));
}
