import 'package:dio/dio.dart';
import 'package:service_shop/app/profile/domain/models/order_model.dart';
import 'package:service_shop/app/profile/domain/repositories/i_profile_repository.dart';

class ProfileRepository implements IProfileRepository {
  final Dio _dio;

  const ProfileRepository(this._dio);

  @override
  Future<List<OrderModelInfo>> getOrderInfoList(String status) async {
    try {
      final response = await _dio.get(
        '/orders',
        queryParameters: {'status': status},
      );

      final List<OrderModelInfo> orderInfoList = (response.data as List)
          .map((orderJson) => OrderModelInfo.fromJson(orderJson))
          .toList();

      return orderInfoList;
    } on DioException catch (e) {
      // Handle Dio exceptions
      throw Exception('Failed to load order info list: ${e.message}');
    } catch (e) {
      // Handle any other exceptions
      throw Exception('An unexpected error occurred: $e');
    }
  }
}
