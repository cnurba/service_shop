import 'package:equatable/equatable.dart';
import 'package:service_shop/app/search/domain/models/category_model.dart';
import 'package:service_shop/app/search/domain/models/filter_model.dart';

class QueryParamsState extends Equatable {
  final CategoryModel? category;
  final String searchText;
  final String sortText;
  final List<FilterPropertyModel> filters;
  final double minPrice;
  final double maxPrice;

  const QueryParamsState({
    required this.category,
    required this.searchText,
    required this.sortText,
    required this.filters,
    required this.minPrice,
    required this.maxPrice,
  });

  factory QueryParamsState.initial() {
    return QueryParamsState(
      category: null,
      searchText: '',
      sortText: '',
      filters: [],
      minPrice: 0,
      maxPrice: 0,
    );
  }

  QueryParamsState copyWith({
    CategoryModel? category,
    String? searchText,
    String? sortText,
    List<FilterPropertyModel>? filters,
    double? minPrice,
    double? maxPrice,
  }) {

    var cat = category;
    if (category == null) {
      cat = null;
    }else{
      cat = this.category;
    }
    return QueryParamsState(
      category: category ?? cat,
      searchText: searchText ?? this.searchText,
      sortText: sortText ?? this.sortText,
      filters: filters ?? this.filters,
      minPrice: minPrice ?? this.minPrice,
      maxPrice: maxPrice ?? this.maxPrice,
    );
  }

  @override
  List<Object?> get props => [
    category,
    searchText,
    sortText,
    filters,
    minPrice,
    maxPrice,
  ];
}
