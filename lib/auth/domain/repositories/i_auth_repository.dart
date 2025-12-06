
import 'package:service_shop/app/profile/domain/models/user_edit_model.dart';
import 'package:service_shop/auth/domain/models/token.dart';

abstract class IAuthRepository {
  Future<(bool,Token?)> enter();
  Future<void> logout();
  Future<bool> isSignIn();

  Future<bool> registerUser(UserProfile userProfile);

  Future<bool> sendSms(String phone);
  Future<bool> verifySms(String code, String phone);
}
