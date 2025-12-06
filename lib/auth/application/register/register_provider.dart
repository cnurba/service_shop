import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:service_shop/auth/application/register/register_controller.dart';
import 'package:service_shop/auth/application/register/register_state.dart';
import 'package:service_shop/auth/domain/repositories/i_auth_repository.dart';
import 'package:service_shop/injection.dart';

final registerProvider =
    StateNotifierProvider<RegisterController, RegisterState>(
      (ref) => RegisterController(getIt<IAuthRepository>()),
    );
