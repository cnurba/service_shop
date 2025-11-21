import 'package:dio/dio.dart';
import 'package:service_shop/app/basket/domain/repositories/i_basket_repository.dart';

class BasketRepository implements IBasketRepository {
  final Dio _dio;
  const BasketRepository(this._dio);

  @override
  Future<bool> addOrder(Map<String, dynamic> orderData) async {
    try {
      final response = await _dio.post('/orders', data: orderData);
      return true;
    } on DioException catch (e) {
      // Handle Dio exceptions
      throw Exception('Failed to post order: ${e.message}');
    } catch (e) {
      // Handle any other exceptions
      throw Exception('An unexpected error occurred: $e');
    }
  }
}

