import '../../application/profile_edit/profile_edit_controller.dart';

void updateProfileField(
  ProfileEditController controller,
  String field,
  String value,
) {
  switch (field) {
    case 'firstName':
      controller.setFirstName(value);
      break;
    case 'lastName':
      controller.setLastName(value);
      break;
    case 'birthDate':
      controller.setBirthDate(value);
      break;
    case 'gender':
      controller.setGender(value);
      break;
    case 'phone':
      controller.setPhone(value);
      break;
    case 'email':
      controller.setEmail(value);
      break;
    case 'password':
      controller.setPassword(value);
      break;
  }
}
