import 'package:service_shop/app/core/models/data_tree.dart';
import 'package:service_shop/app/core/models/products/product.dart';
import 'package:service_shop/app/core/models/products/product_category.dart';
import 'package:service_shop/app/shop/domain/models/shop.dart';

abstract class IShopRepository {
  Future<List<Shop>> getShops();
  Future<bool> likeShop(String shopUuid);
  Future<bool> unlikeShop(String shopUuid);
  Future<List<ProductCategory>> getShopProducts(String shopUuid);
  Future<DataTree> getProductDetail({
    required String shopUuid,
    required String productUuid,
  });
  Future<bool> likeProduct(String propertyUuid, String shopUuid);
  Future<bool> unlikeProduct(String propertyUuid, String shopUuid);
  Future<List<Product>> getFavoriteProduct();
  // Future<bool> deleteFavoritProduct(String propertyUuid, String shopUuid);
}
