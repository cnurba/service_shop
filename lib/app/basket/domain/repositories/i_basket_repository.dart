import 'package:service_shop/app/core/models/data_tree.dart';
import 'package:service_shop/app/core/models/products/product_category.dart';
import 'package:service_shop/app/shop/domain/models/shop.dart';

abstract class IBasketRepository {
  Future<bool> addOrder(Map<String, dynamic> orderData);

}
