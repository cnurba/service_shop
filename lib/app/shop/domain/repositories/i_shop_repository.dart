import 'package:service_shop/app/core/models/data_tree.dart';
import 'package:service_shop/app/core/models/products/product_category.dart';
import 'package:service_shop/app/shop/domain/models/shop.dart';

abstract class IShopRepository {
  Future<List<Shop>> getShops();
  Future<List<ProductCategory>> getShopProducts(String shopUuid);
  Future<DataTree> getProductDetail({required String shopUuid, required String productUuid});
}