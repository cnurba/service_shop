import 'package:equatable/equatable.dart';
import 'package:service_shop/app/search/domain/models/filter_model.dart';
import 'package:service_shop/core/enum/state_type.dart';


class FiltersState extends Equatable {
  final List<FilterModel> filters;
  final StateType stateType;
  final String? error;

  const FiltersState({
    this.filters = const [],
    this.stateType = StateType.initial,
    this.error,
  });

  FiltersState copyWith({
    List<FilterModel>? filters,
    StateType? stateType,
    String? error,
  }) {
    return FiltersState(
      filters: filters ?? this.filters,
      stateType: stateType ?? this.stateType,
      error: error,
    );
  }

  @override
  List<Object?> get props => [ filters, stateType, error];
}

