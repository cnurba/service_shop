import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:service_shop/app/profile/application/profile_edit/profile_edit_state.dart';

class ProfileEditController extends StateNotifier<ProfileEditState> {
  ProfileEditController() : super(ProfileEditState.initial());

  // Individual field updaters
  void setFirstName(String name) {
    state = state.copyWith(firstName: name);
  }

  void setLastName(String name) {
    state = state.copyWith(lastName: name);
  }

  void setBirthDate(String date) {
    state = state.copyWith(birthDate: date);
  }

  void setGender(String gender) {
    state = state.copyWith(gender: gender);
  }

  void setPhone(String phone) {
    state = state.copyWith(phone: phone);
  }

  void setEmail(String email) {
    state = state.copyWith(email: email);
  }

  void setPassword(String password) {
    state = state.copyWith(password: password);
  }
}
