import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:service_shop/auth/application/auth_provider/auth_state.dart';
import 'package:service_shop/auth/domain/repositories/i_auth_repository.dart';

class AuthController extends StateNotifier<AuthState> {
  /// Creates a NewOrderController with an initial state.
  AuthController(this._api) : super(AuthInitial());

  final IAuthRepository _api;

  /// Login function with _api.

  Future<void> authCheckRequest() async {
    state = AuthLoading();
    try {
      final isSignedIn = await _api.isSignIn();
      log("Auth check result: $isSignedIn");
      if (isSignedIn) {
        state = AuthAuthenticated();
      } else {
        await enter();
        //state = AuthUnAuthenticated();
      }
    } catch (e) {
      log("Auth check error: $e");
      state = AuthUnAuthenticated();
    }
  }

  Future<void> enter() async {
    state = AuthLoading();
    try {
      final result = await _api.enter();
      if (result.$1) {
        state = AuthAuthenticated();
      } else {
        state = AuthUnAuthenticated();
      }
    } catch (e) {
      log("Login error: $e");
      state = AuthUnAuthenticated();
    }
  }

  Future<void> signOut() async {
    state = AuthLoading();
    try {
      await _api.logout();
      log("Sign out successful");
      state = AuthUnAuthenticated();
    } catch (e) {
      log("Sign out error: $e");
      state = AuthUnAuthenticated();
    }
  }
}
