import '../../domain/models/category_model.dart';

enum CategoryListStatus { initial, loading, loaded, error }

class CategoryListState {
  final List<CategoryModel> categories;
  final CategoryListStatus status;
  final String? error;

  CategoryListState({
    this.categories = const [],
    this.status = CategoryListStatus.initial,
    this.error,
  });

  CategoryListState copyWith({
    List<CategoryModel>? categories,
    CategoryListStatus? status,
    String? error,
  }) {
    return CategoryListState(
      categories: categories ?? this.categories,
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }
  factory CategoryListState.initial() {
    return CategoryListState(
      categories: [],
      status: CategoryListStatus.initial,
      error: null,
    );
  }
}
