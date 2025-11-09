import 'package:dio/dio.dart';
import 'package:service_shop/app/core/models/data_tree.dart';
import 'package:service_shop/app/core/models/products/product_category.dart';
import 'package:service_shop/app/shop/domain/models/shop.dart';
import 'package:service_shop/app/shop/domain/repositories/i_shop_repository.dart';

class ShopRepository implements IShopRepository {
  final Dio _dio;

  const ShopRepository(this._dio);

  @override
  Future<List<Shop>> getShops() async {
    try {
      final response = await _dio.get('/branches');

      final List<Shop> shops = (response.data as List)
          .map((shopJson) => Shop.fromJson(shopJson))
          .toList();

      return shops;
    } on DioException catch (e) {
      // Handle Dio exceptions
      throw Exception('Failed to load shops: ${e.message}');
    } catch (e) {
      // Handle any other exceptions
      throw Exception('An unexpected error occurred: $e');
    }
  }

  @override
  Future<List<ProductCategory>> getShopProducts(String shopUuid) async {
    try {
      final response = await _dio.get(
        '/branchProducts',
        queryParameters: {'shopUuid': shopUuid},
      );

      final List<ProductCategory> shopProducts = (response.data as List)
          .map((categoryJson) => ProductCategory.fromJson(categoryJson))
          .toList();

      return shopProducts;
    } on DioException catch (e) {
      // Handle Dio exceptions
      throw Exception('Failed to load shop products: ${e.message}');
    } catch (e) {
      // Handle any other exceptions
      throw Exception('An unexpected error occurred: $e');
    }
  }

  @override
  Future<DataTree> getProductDetail({
    required String shopUuid,
    required String productUuid,
  }) async {
    try {
      final response = await _dio.get(
        '/branchProducts/byProductUuid',
        queryParameters: {'shopUuid': shopUuid, 'productUuid': productUuid},
      );

      final DataTree productDetail = DataTree.fromJson(response.data);

      return productDetail;
    } on DioException catch (e) {
      // Handle Dio exceptions
      throw Exception('Failed to load shop products: ${e.message}');
    } catch (e) {
      // Handle any other exceptions
      throw Exception('An unexpected error occurred: $e');
    }
  }
}

// Repository methods would go her
