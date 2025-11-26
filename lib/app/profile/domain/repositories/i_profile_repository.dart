import 'package:service_shop/app/profile/domain/models/order_model.dart';

abstract class IProfileRepository {
  Future<List<OrderModelInfo>> getOrderInfoList(String status);
}
