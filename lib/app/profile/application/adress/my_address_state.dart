import 'package:service_shop/app/profile/domain/models/my_address.dart';
import 'package:service_shop/core/enum/state_type.dart';

enum MyAddressStatus { initial, loading, loaded, error }

class MyAddressState {
  final List<MyAddressModel> addresses;
  final StateType status;
  final String? error;

  const MyAddressState({
    this.addresses = const [],
    this.status = StateType.initial,
    this.error,
  });

  MyAddressState copyWith({
    List<MyAddressModel>? addresses,
    StateType? status,
    String? error,
  }) {
    return MyAddressState(
      addresses: addresses ?? this.addresses,
      status: status ?? this.status,
      error: error,
    );
  }

  List<Object?> get props => [addresses, status, error];
}
