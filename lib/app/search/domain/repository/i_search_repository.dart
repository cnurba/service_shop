import 'package:service_shop/app/search/domain/models/category_model.dart';
import 'package:service_shop/app/search/domain/models/filter_model.dart';

abstract class ISearchRepository {
  Future<List<CategoryModel>> getCategories();
  Future<List<FilterModel>> getFilterModels(String? categoryUuid);

}