import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:service_shop/auth/domain/models/token.dart';
import 'package:service_shop/auth/domain/repositories/i_auth_repository.dart';
import 'package:service_shop/auth/domain/repositories/i_token_storage.dart';
import 'package:service_shop/core/http/endpoints.dart';

class AuthRepository implements IAuthRepository {
  final ITokenStorage _tokenStorage;
  final Dio _dio;

  AuthRepository(this._tokenStorage, this._dio);

  @override
  Future<(bool, Token?)> enter() async {
    try {
      log("START ENTER");
      final basicAuth =
          'Basic ${base64Encode(utf8.encode('MobileClientUser:6KO6n#NvmH2}b2DNcP'))}';

      Map<String, String> headers = {
        'content-type': 'application/json',
        'accept': 'application/json',
        'Authorization': basicAuth,
      };

      final tokenFromStorage = await _tokenStorage.read();

      if(tokenFromStorage != null) {
        log("Token already exists, skipping login.");
        return (true, tokenFromStorage);
      }

      final responseData = await _dio.post(
        Endpoints.auth.enter,
        queryParameters: {"fcm": "fcm_token_placeholder"},
        options: Options(headers: headers),
      );
      log("FINISH ENTER ${responseData.data.toString()}");
      final token = Token.fromJson(responseData.data);
      await _tokenStorage.save(token);
      return (true, token);
    } on DioException catch (e) {
      log("Error during login: ${e.message}");
      if (e.response?.statusCode == 401) {
        return (false, null);
      } else {
        return (false, null);
      }
    } catch (e) {
      log("Unexpected error during login: $e");
      return (false, null);
    }
  }

  @override
  Future<void> logout() async {
    await _tokenStorage.clear();
  }

  @override
  Future<bool> isSignIn() async {
    final token = await _tokenStorage.read();
    if (token == null) {
      return false;
    }
    return true;
  }
}
