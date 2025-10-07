class UserProfile {
  final String firstName;
  final String lastName;
  final String birthDate;
  final String gender;
  final String phone;
  final String email;
  final String password;

  UserProfile({
    required this.firstName,
    required this.lastName,
    required this.birthDate,
    required this.gender,
    required this.phone,
    required this.email,
    required this.password,
  });

  UserProfile copyWith({
    String? firstName,
    String? lastName,
    String? birthDate,
    String? gender,
    String? phone,
    String? email,
    String? password,
  }) {
    return UserProfile(
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
