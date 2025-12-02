import 'package:equatable/equatable.dart';
import 'package:service_shop/core/enum/state_type.dart';

class ProfileEditState extends Equatable {
  final StateType status;
  final String? error;
  final String firstName;
  final String lastName;
  final String birthDate;
  final String gender;
  final String phone;
  final String email;
  final String password;
  final String imageUrl = '';

  const ProfileEditState({
    required this.status,
    required this.error,
    required this.firstName,
    required this.lastName,
    required this.birthDate,
    required this.gender,
    required this.phone,
    required this.email,
    required this.password,
  });

  factory ProfileEditState.initial() {
    return const ProfileEditState(
      status: StateType.initial,
      error: null,
      firstName: '',
      lastName: '',
      birthDate: '',
      gender: '',
      phone: '',
      email: '',
      password: '',
    );
  }

  ProfileEditState copyWith({
    StateType? status,
    String? error,
    String? firstName,
    String? lastName,
    String? birthDate,
    String? gender,
    String? phone,
    String? email,
    String? password,
  }) {
    return ProfileEditState(
      status: status ?? this.status,
      error: error ?? this.error,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      birthDate: birthDate ?? this.birthDate,
      gender: gender ?? this.gender,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  @override
  List<Object?> get props => [
    status,
    error,
    firstName,
    lastName,
    birthDate,
    gender,
    phone,
    email,
    password,
  ];
}
