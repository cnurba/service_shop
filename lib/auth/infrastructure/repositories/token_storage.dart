import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:service_shop/auth/domain/models/token.dart';
import 'package:service_shop/auth/domain/repositories/i_token_storage.dart';

/// Defines secure storage for saving token.
class TokenStorage implements ITokenStorage {
  /// Secure storage instance.
  final FlutterSecureStorage _storage;

  TokenStorage(this._storage);

  static const _accessToken = 'accessToken';

  @override
  Future<Token?> read() async {
    final tokenString = await _storage.read(key: _accessToken);

    if (tokenString == null) {
      return null;
    }
    return Token.fromJson(json.decode(tokenString));
  }

  @override
  Future<void> save(Token token) async {
    await _storage.write(key: _accessToken, value: json.encode(token.toJson()));
  }

  @override
  Future<void> clear() async {
    await _storage.deleteAll();
  }
}
