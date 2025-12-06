import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:service_shop/auth/application/auth_provider/auth_controller.dart';
import 'package:service_shop/auth/application/auth_provider/auth_state.dart';
import 'package:service_shop/auth/domain/repositories/i_auth_repository.dart';
import 'package:service_shop/injection.dart';

/// Provides the AuthController instance
final authProvider = StateNotifierProvider<AuthController, AuthState>(
  (ref) {
    final authRepository = getIt<IAuthRepository>();
    return AuthController(authRepository);
  },
);
