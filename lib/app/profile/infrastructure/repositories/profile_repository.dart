import 'package:dio/dio.dart';
import 'package:service_shop/app/profile/domain/models/my_address.dart';
import 'package:service_shop/app/profile/domain/models/order_model.dart';
import 'package:service_shop/app/profile/domain/repositories/i_profile_repository.dart';

class ProfileRepository implements IProfileRepository {
  final Dio _dio;

  const ProfileRepository(this._dio);

  @override
  Future<List<OrderModelInfo>> getOrderInfoList(String status) async {
    try {
      final response = await _dio.get(
        '/orders/byStatus',
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

  @override
  Future<List<MyAddressModel>> getMyAddress() async {
    try {
      final response = await _dio.get('/user/myAddresses');

      final List<MyAddressModel> data = (response.data as List)
          .map((addressJson) => MyAddressModel.fromJson(addressJson))
          .toList();
      return data;
    } on DioException catch (e) {
      throw Exception('Failed to load my address; ${e.message}');
    } catch (e) {
      throw Exception('An unexpected error occurred: $e');
    }
  }

  @override
  Future<bool> addNewAddress(MyAddressModel address) async {
    try {
      final response = await _dio.post(
        '/user/addresses',
        data: address.toJson(),
      );
      return Future.value(true);
    } on DioException catch (e) {
      throw Exception('Failed to add new address: ${e.message}');
    } catch (e) {
      throw Exception('An unexpected error occurred: $e');
    }
  }
}
