import 'package:service_shop/app/profile/domain/models/my_address.dart';
import 'package:service_shop/app/profile/domain/models/order_model.dart';

abstract class IProfileRepository {
  Future<List<OrderModelInfo>> getOrderInfoList(String status);
  Future<List<MyAddressModel>> getMyAddress();
  Future<bool> addNewAddress(MyAddressModel address);
}
