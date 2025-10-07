import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:service_shop/app/profile/application/profile_edit/profile_edit_state.dart';

class ProfileEditController extends StateNotifier<ProfileEditState> {
  ProfileEditController() : super(const ProfileEditState());

  // Update any field
  void updateField(String field, String value) {
    switch (field) {
      case 'firstName':
        state = state.copyWith(firstName: value);
        break;
      case 'lastName':
        state = state.copyWith(lastName: value);
        break;
      case 'birthDate':
        state = state.copyWith(birthDate: value);
        break;
      case 'gender':
        state = state.copyWith(gender: value);
        break;
      case 'phone':
        state = state.copyWith(phone: value);
        break;
      case 'email':
        state = state.copyWith(email: value);
        break;
      case 'password':
        state = state.copyWith(password: value);
        break;
    }
  }
}
