import 'package:dio/dio.dart';
import 'package:service_shop/app/shop/domain/models/shop.dart';
import 'package:service_shop/app/shop/domain/repositories/i_shop_repository.dart';

class ShopRepository implements IShopRepository {
  final Dio _dio;

  const ShopRepository(this._dio);

  @override
  Future<List<Shop>> getShops() async {
    try {
      final response = await _dio.get('/branches');

      final List<Shop> shops = (response.data as List)
          .map((shopJson) => Shop.fromJson(shopJson))
          .toList();

      return shops;
    } on DioException catch (e) {
      // Handle Dio exceptions
      throw Exception('Failed to load shops: ${e.message}');
    } catch (e) {
      // Handle any other exceptions
      throw Exception('An unexpected error occurred: $e');
    }
  }
}

// Repository methods would go her
