import 'package:service_shop/app/shop/domain/models/shop.dart';

abstract class IShopRepository {
  Future<List<Shop>> getShops();
}