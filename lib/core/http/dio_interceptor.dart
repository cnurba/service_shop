import 'package:dio/dio.dart';
import 'package:service_shop/auth/domain/repositories/i_token_storage.dart';


class DioInterceptor extends Interceptor {
  final Dio dio;
  final ITokenStorage tokenStorage; // a class that reads/writes tokens
  const DioInterceptor(this.dio, this.tokenStorage);

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await tokenStorage.read();
    if (token != null && token.accessToken.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer ${token.accessToken}';
    }
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {

    handler.next(err);
  }


  bool _isUnauthorized(DioException err) {
    return err.response?.statusCode == 401;
  }

  bool _shouldRefresh(RequestOptions requestOptions) {
    // Avoid refreshing again if it's the refresh token call
    return !requestOptions.path.contains('/refresh');
  }

  RequestOptions _retryRequest(RequestOptions requestOptions, String newToken) {
    final newHeaders = Map<String, dynamic>.from(requestOptions.headers);
    newHeaders['Authorization'] = 'Bearer $newToken';
    return requestOptions.copyWith(headers: newHeaders);
  }

  Future<String?> _refreshAccessToken() async {
    try {
      // Call your /refresh endpoint
      // final response = await Dio().post(
      //   Endpoints.auth.refresh,
      //   data: {'refresh_token': (await tokenStorage.read())?.refresh},
      // );
      // final newAccessToken = response.data['access_token'];
      // final newRefreshToken = response.data['refresh_token'];
      // //final newAccessToken = 'FAKE_NEW_TOKEN';
      // final token = Token(access: newAccessToken, refresh: newRefreshToken);
      // await tokenStorage.save(token);
      // return token;
    } catch (e) {
      // If fail, remove token or force user to re-log
      // await tokenStorage.clear();
      // return null;
    } finally {
      // Allow future refresh attempts next time 401 is encountered
     // _refreshTokenFuture = null;
    }
  }
}
