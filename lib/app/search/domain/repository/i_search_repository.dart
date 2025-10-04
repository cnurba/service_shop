import 'package:service_shop/app/search/domain/models/category_model.dart';

abstract class ISearchRepository {
  Future<List<CategoryModel>> getCategories();
}