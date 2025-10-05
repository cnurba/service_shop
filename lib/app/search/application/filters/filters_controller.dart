import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:service_shop/app/search/application/filters/filters_state.dart';
import 'package:service_shop/app/search/domain/repository/i_search_repository.dart';
import 'package:service_shop/core/enum/state_type.dart';
import 'package:service_shop/injection.dart';

final filtersProvider = StateNotifierProvider<FiltersController, FiltersState>((
  ref,
) {
  return FiltersController(getIt<ISearchRepository>());
});

class FiltersController extends StateNotifier<FiltersState> {
  final ISearchRepository repository;

  FiltersController(this.repository) : super(const FiltersState());

  Future<void> fetchFilters(String? categoryUuid) async {
    state = state.copyWith(stateType: StateType.loading, error: null);
    try {
      final result = await repository.getFilterModels(categoryUuid);
      state = state.copyWith(filters: result, stateType: StateType.loaded);
    } catch (e) {
      state = state.copyWith(stateType: StateType.error, error: e.toString());
    }
  }
}
