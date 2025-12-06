import 'dart:io';

import 'package:dio/dio.dart';
import 'package:service_shop/app/profile/domain/models/my_address.dart';
import 'package:service_shop/app/profile/domain/models/order_model.dart';
import 'package:service_shop/app/profile/domain/models/user_edit_model.dart';
import 'package:service_shop/app/profile/domain/repositories/i_profile_repository.dart';
import 'package:service_shop/auth/domain/repositories/i_token_storage.dart';

class ProfileRepository implements IProfileRepository {
  final Dio _dio;
  final ITokenStorage _tokenStorage;

  const ProfileRepository(this._dio, this._tokenStorage);

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

  @override
  Future<UserProfile> getCurrentUser() async {
    try {
      final tokenFromStorage = await _tokenStorage.read();

      if (tokenFromStorage != null) {
        final response = await _dio.get(
          '/mobileAuth/currentUser',
          queryParameters: {"uuid": tokenFromStorage.userUuid},
        );

        final userProfile = UserProfile.fromJson(response.data);
        return userProfile;
      }
      return UserProfile.empty();
    } on DioException catch (e) {
      // Handle Dio exceptions
      throw Exception('Failed to load order info list: ${e.message}');
    } catch (e) {
      // Handle any other exceptions
      throw Exception('An unexpected error occurred: $e');
    }
  }

  @override
  Future<UserProfile?> updateUserProfile(UserProfile profile) async {
    try {
      final tokenFromStorage = await _tokenStorage.read();

      if (tokenFromStorage != null) {
        final response = await _dio.put(
          '/mobileAuth',
          queryParameters: {"uuid": tokenFromStorage.userUuid},
          data: profile.toJson(),
        );
        final userProfile = UserProfile.fromJson(response.data);
        return userProfile;
      }
      return null;
    } on DioException catch (e) {
      // Handle Dio exceptions
      throw Exception('Failed to load order info list: ${e.message}');
    } catch (e) {
      // Handle any other exceptions
      throw Exception('An unexpected error occurred: $e');
    }
  }

  @override
  Future<String> setProfileImage(File file) async {
    try {
      final tokenFromStorage = await _tokenStorage.read();

      if (tokenFromStorage != null) {
        String fileName = file.path.split('/').last;

        FormData formData = FormData.fromMap({
          "image": await MultipartFile.fromFile(file.path, filename: fileName),

        });
        final response = await _dio.post(
          '/mobileAuth/uploadProfileImage',
          queryParameters: {
            "uuid": tokenFromStorage.userUuid,
            'catalog': 'MobileUser',
          },

          data: formData,
        );
        final imageUrl = response.data;
        return imageUrl;
      }
      return '';
    } on DioException catch (e) {
      // Handle Dio exceptions
      throw Exception('Failed to upload profile image: ${e.message}');
    } catch (e) {
      // Handle any other exceptions
      throw Exception('An unexpected error occurred: $e');
    }
  }
}
