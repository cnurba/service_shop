import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:service_shop/app/profile/application/profile_edit/profile_edit_state.dart';
import 'package:service_shop/app/profile/domain/models/user_edit_model.dart';
import 'package:service_shop/app/profile/domain/repositories/i_profile_repository.dart';
import 'package:service_shop/core/enum/state_type.dart';

class ProfileEditController extends StateNotifier<ProfileEditState> {
  ProfileEditController(this._api) : super(ProfileEditState.initial());

  final IProfileRepository _api;

  Future<void> updateProfile() async {
    state = state.copyWith(status: StateType.loading);
    final result = await _api.updateUserProfile(state.userProfile);

    Future.delayed(const Duration(seconds: 2));
    if (result != null) {
      state = state.copyWith(status: StateType.loaded, userProfile: result);
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

  void resetState() {
    state = ProfileEditState.initial();
  }
}
