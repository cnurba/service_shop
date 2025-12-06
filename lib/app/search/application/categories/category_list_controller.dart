import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:service_shop/app/search/domain/repository/i_search_repository.dart';
import 'category_list_state.dart';

class CategoryListController extends StateNotifier<CategoryListState> {
  final ISearchRepository repository;

  CategoryListController(this.repository) : super(CategoryListState.initial());

  Future<void> loadCategories() async {
    state = state.copyWith(status: CategoryListStatus.loading, error: null);
    try {
      await Future.delayed(const Duration(seconds: 1));
      final categories = await repository.getCategories();
      state = state.copyWith(
        categories: categories,
        status: CategoryListStatus.loaded,
      );
    } catch (e) {
      state = state.copyWith(
        status: CategoryListStatus.error,
        error: e.toString(),
      );
    }
  }
}
