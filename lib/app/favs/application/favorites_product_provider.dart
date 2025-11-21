// lib/app/favs/application/favourite_products_provider.dart

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:service_shop/app/core/models/products/product.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:service_shop/auth/infrastructure/repositories/token_storage.dart';

final favouriteProductsProvider = FutureProvider<List<Product>>((ref) async {
  // Dio түз түзөбүз
  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://metal.tez.kg/seitek/hs/clientMobile',
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 20),
    ),
  );

  // Сенин бар TokenStorage'иңди түз колдонобуз
  final tokenStorage = TokenStorage(const FlutterSecureStorage());

  // Токенди окуйбуз
  final token = await tokenStorage.read();

  // Токен бар болсо — header'ге кошобуз
  if (token != null && token.accessToken.isNotEmpty) {
    dio.options.headers['Authorization'] = 'Bearer ${token.accessToken}';
  }

  try {
    final response = await dio.get('/like');

    if (response.statusCode == 200) {
      final List<dynamic> data = response.data as List;
      return data.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception('Сервер ката кайтарды: ${response.statusCode}');
    }
  } on DioException catch (e) {
    String errorMessage = 'Белгисиз ката';

    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout) {
      errorMessage = 'Интернет жай же жок';
    } else if (e.response?.statusCode == 401) {
      errorMessage = 'Сессия аяктады. Кайра кириңиз';
    } else if (e.response != null) {
      errorMessage = e.response?.data.toString() ?? 'Серверден ката';
    } else {
      errorMessage = 'Интернет байланышы жок';
    }

    throw Exception(errorMessage);
  } catch (e) {
    throw Exception('Күтпөгөн ката: $e');
  }
});
