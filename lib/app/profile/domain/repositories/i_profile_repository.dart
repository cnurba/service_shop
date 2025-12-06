import 'dart:io';

import 'package:service_shop/app/profile/domain/models/my_address.dart';
import 'package:service_shop/app/profile/domain/models/order_model.dart';
import 'package:service_shop/app/profile/domain/models/user_edit_model.dart';

abstract class IProfileRepository {
  Future<List<OrderModelInfo>> getOrderInfoList(String status);
  Future<List<MyAddressModel>> getMyAddress();
  Future<bool> addNewAddress(MyAddressModel address);
  Future<UserProfile> getCurrentUser();
  Future<UserProfile?> updateUserProfile(UserProfile profile);

  Future<String> setProfileImage(File file);
}
