enum ProfileStatus { initial, loading, loaded, error }

class ProfileEditState {
  final ProfileStatus status;
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
    this.status = ProfileStatus.initial,
    this.error,
    this.firstName = '',
    this.lastName = '',
    this.birthDate = '',
    this.gender = '',
    this.phone = '',
    this.email = '',
    this.password = '',
  });

  ProfileEditState copyWith({
    ProfileStatus? status,
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
}
