import 'package:equatable/equatable.dart';

class UserProfile extends Equatable {
  final String firstName;
  final String lastName;
  final DateTime birthDate;
  final String gender;
  final String phone;
  final String email;
  final String password;
  final String repeatPassword;
  final String imageUrl;

  const UserProfile({
    required this.firstName,
    required this.lastName,
    required this.birthDate,
    required this.gender,
    required this.phone,
    required this.email,
    required this.password,
    required this.imageUrl,
    required this.repeatPassword,
  });

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'birthDate': birthDate.toIso8601String(),
      'gender': gender,
      'phone': phone,
      'email': email,
      'password': password,
      'imageUrl': imageUrl,
    };
  }

  bool get isUserRegistered {
    return firstName.isNotEmpty &&
        lastName.isNotEmpty &&
        gender.isNotEmpty;

  }

  String get fullName {
    return '$firstName $lastName';
  }

  factory UserProfile.empty() {
    return UserProfile(
      firstName: "",
      lastName: "",
      birthDate: DateTime.now(),
      gender: "",
      phone: "",
      email: "",
      password: "",
      imageUrl: "",
      repeatPassword: "",
    );
  }

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      firstName: json['firstName'],
      lastName: json['lastName'],
      birthDate: json['birthDate'] == null
          ? DateTime.now()
          : DateTime.parse(json['birthDate']),
      gender: json['gender'] ?? "",
      phone: json['phone'] ?? "",
      email: json['email'] ?? "",
      password: json['password'] ?? "",
      imageUrl: json['imageUrl'] ?? "",
      repeatPassword: json['password'] ?? "",
    );
  }

  UserProfile copyWith({
    String? firstName,
    String? lastName,
    DateTime? birthDate,
    String? gender,
    String? phone,
    String? email,
    String? password,
    String? repeatPassword,
    String? imageUrl,
  }) {
    return UserProfile(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      birthDate: birthDate ?? this.birthDate,
      gender: gender ?? this.gender,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      password: password ?? this.password,
      repeatPassword: repeatPassword ?? this.repeatPassword,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  @override
  List<Object?> get props => [
    firstName,
    lastName,
    birthDate,
    gender,
    phone,
    email,
    password,
    imageUrl,
    repeatPassword,
  ];
}
