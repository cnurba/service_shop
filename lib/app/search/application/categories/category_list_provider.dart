

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:service_shop/app/search/application/categories/category_list_controller.dart';
import 'package:service_shop/app/search/application/categories/category_list_state.dart';
import 'package:service_shop/app/search/domain/repository/i_search_repository.dart';
import 'package:service_shop/injection.dart';

final categoriesProvider = StateNotifierProvider<CategoryListController, CategoryListState>((ref) {
  return CategoryListController(getIt<ISearchRepository>());
});
