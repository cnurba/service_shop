import 'package:service_shop/auth/domain/models/token.dart';

/// Describe method of secure storage.
abstract class ITokenStorage {
  /// Get token.
  Future<Token?> read();

  /// Save token.
  Future<void> save(Token token);

  /// Clear storage.
  Future<void> clear();
}
