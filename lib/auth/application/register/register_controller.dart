import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:service_shop/app/profile/domain/models/user_edit_model.dart';
import 'package:service_shop/auth/application/register/register_state.dart';
import 'package:service_shop/auth/domain/repositories/i_auth_repository.dart';
import 'package:service_shop/core/enum/state_type.dart';

class RegisterController extends StateNotifier<RegisterState> {
  RegisterController(this._authRepository) : super(RegisterState.initial());

  final IAuthRepository _authRepository;

  Future<void> register() async {
    state = state.copyWith(status: StateType.loading);
    final result = await _authRepository.registerUser(state.userProfile);

    if (result) {
      state = state.copyWith(status: StateType.loaded);
    } else {
      state = state.copyWith(status: StateType.error);
    }
  }

  void setImageUrl(String url) {
    state = state.copyWith(
      userProfile: state.userProfile.copyWith(imageUrl: url),
    );
  }

  void setUserProfile(UserProfile profile) {
    state = state.copyWith(userProfile: profile);
  }

  void setFirstName(String name) {
    state = state.copyWith(
      userProfile: state.userProfile.copyWith(firstName: name),
    );
  }

  void setLastName(String name) {
    state = state.copyWith(
      userProfile: state.userProfile.copyWith(lastName: name),
    );
  }

  void setBirthDate(DateTime birthDate) {
    state = state.copyWith(
      userProfile: state.userProfile.copyWith(birthDate: birthDate),
    );
  }

  void setGender(String gender) {
    state = state.copyWith(
      userProfile: state.userProfile.copyWith(gender: gender),
    );
  }

  void setPhone(String phone) {
    state = state.copyWith(
      userProfile: state.userProfile.copyWith(phone: phone),
    );
  }

  void setEmail(String email) {
    state = state.copyWith(
      userProfile: state.userProfile.copyWith(email: email),
    );
  }

  void setPassword(String password) {
    state = state.copyWith(
      userProfile: state.userProfile.copyWith(password: password),
    );
  }

  void setRepeatPassword(String repeatPassword) {
    state = state.copyWith(
      userProfile: state.userProfile.copyWith(repeatPassword: repeatPassword),
    );
  }
}
