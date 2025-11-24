import 'package:equatable/equatable.dart';
import 'package:service_shop/core/enum/state_type.dart';

class AddOrderState extends Equatable {
  final StateType status;
  final String? error;

  const AddOrderState({this.status = StateType.initial, this.error});

  factory AddOrderState.initial() {
    return const AddOrderState();
  }

  AddOrderState copyWith({StateType? status, String? error}) {
    return AddOrderState(
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [status, error];
}
