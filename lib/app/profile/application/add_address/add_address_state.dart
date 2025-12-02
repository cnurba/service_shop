import 'package:equatable/equatable.dart';
import 'package:service_shop/core/enum/state_type.dart';

class AddAddressState extends Equatable {
  final StateType status;
  final String? error;

  const AddAddressState({this.error, this.status = StateType.initial});

  AddAddressState copyWith({StateType? status, String? error}) {
    return AddAddressState(status: status ?? this.status, error: error);
  }

  @override
  List<Object?> get props => [status, error];
}
