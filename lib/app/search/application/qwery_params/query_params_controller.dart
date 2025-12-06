import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:service_shop/app/search/application/qwery_params/qwery_params.dart';
import 'package:service_shop/app/search/domain/models/category_model.dart';
import 'package:service_shop/app/search/domain/models/filter_model.dart';

class QueryParamsController extends StateNotifier<QueryParamsState> {
  QueryParamsController() : super(QueryParamsState.initial());

  void setCategory(CategoryModel category) {
    state = state.copyWith(category: category);
  }

  void clearCategory() {
    state = state.copyWith(category: null);
  }

  void setMinPrice(double minPrice) {
    state = state.copyWith(minPrice: minPrice);
  }

  void setMaxPrice(double maxPrice) {
    state = state.copyWith(maxPrice: maxPrice);
  }

  void setSortBy(String sortBy) {
    state = state.copyWith(sortText: sortBy);
  }
  void setSearchText(String searchText) {
    state = state.copyWith(searchText: searchText);
  }

  void setFilter(FilterPropertyModel filter) {
    final currentFilters = List<FilterPropertyModel>.from(state.filters);
    final index = currentFilters.indexWhere((f) => f.propertyUuid == filter.propertyUuid);
    if (index != -1) {
      currentFilters[index] = filter;
    } else {
      currentFilters.add(filter);
    }
    state = state.copyWith(filters: currentFilters);
  }

  void removeFilter(FilterPropertyModel property) {
    final currentFilters = List<FilterPropertyModel>.from(state.filters);
    currentFilters.removeWhere((f) => f.propertyUuid == property.propertyUuid);
    state = state.copyWith(filters: currentFilters);
  }

  void clear() {
    state = QueryParamsState.initial();
  }

}