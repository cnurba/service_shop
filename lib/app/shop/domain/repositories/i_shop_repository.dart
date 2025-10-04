import 'package:service_shop/app/shop/domain/models/shop.dart';
import 'package:service_shop/app/shop/domain/models/shop_products.dart';

abstract class IShopRepository {
  Future<List<Shop>> getShops();
  Future<List<ShopProductCategory>> getShopProducts(String shopUuid);
}