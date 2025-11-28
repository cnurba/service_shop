import 'package:equatable/equatable.dart';
import 'package:service_shop/core/enum/state_type.dart';

class NewAddressState extends Equatable {
  final String id;
  final String name;
  final String phone;
  final String city;
  final String street;
  final String apartment;
  final StateType stateType;

  const NewAddressState({
    required this.name,
    required this.id,
    required this.phone,
    required this.city,
    required this.street,
    required this.apartment,
    required this.stateType,
  });

  factory NewAddressState.initial() {
    return const NewAddressState(
      id: '',
      name: '',
      phone: '',
      city: '',
      street: '',
      apartment: '',
      stateType: StateType.initial,
    );
  }

  NewAddressState copyWith({
    String? name,
    String? id,
    String? phone,
    String? city,
    String? street,
    String? apartment,
    StateType? stateType,
  }) {
    return NewAddressState(
      name: name ?? this.name,
      id: id ?? this.id,
      phone: phone ?? this.phone,
      city: city ?? this.city,
      street: street ?? this.street,
      apartment: apartment ?? this.apartment,
      stateType: stateType ?? this.stateType,
    );
  }

  @override
  List<Object?> get props => [
    name,
    phone,
    city,
    street,
    apartment,
    stateType,
    id,
  ];
}
