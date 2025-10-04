

import 'package:service_shop/auth/domain/models/token.dart';

abstract class IAuthRepository {
  Future<(bool,Token?)> enter();
  Future<void> logout();
  Future<bool> isSignIn();
}
