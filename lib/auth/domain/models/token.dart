import 'package:equatable/equatable.dart';

class Token extends Equatable {
  final String userUuid;
  final String accessToken;

  const Token({
    required this.userUuid,
    required this.accessToken,
  });

  @override
  List<Object?> get props => [userUuid, accessToken];

  factory Token.fromJson(Map<String, dynamic> json) {
    return Token(
      userUuid: json['userUuid'] as String,
      accessToken: json['accessToken'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userUuid': userUuid,
      'accessToken': accessToken,
    };
  }
}