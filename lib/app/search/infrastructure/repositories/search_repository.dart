import 'package:dio/dio.dart';
import 'package:service_shop/app/search/domain/models/category_model.dart';
import 'package:service_shop/app/search/domain/repository/i_search_repository.dart';

class SearchRepository implements ISearchRepository {
  final Dio _dio;
  const SearchRepository(this._dio);
  @override
  Future<List<CategoryModel>> getCategories() async {
    try {
      final response = await _dio.get('/categories');
      if (response.statusCode == 200) {
        final List data = response.data as List;
        return data.map((e) => CategoryModel.fromJson(e)).toList();
      } else {
        throw Exception('Failed to load categories');
      }
    } on DioException catch (e) {
      throw Exception('Dio error: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }
}
