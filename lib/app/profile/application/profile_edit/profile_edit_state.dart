import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:service_shop/app/profile/domain/models/user_edit_model.dart';
import 'package:service_shop/core/enum/state_type.dart';

class ProfileEditState extends Equatable {
  final StateType status;
  final String? error;
  final UserProfile userProfile;

  const ProfileEditState({
    required this.status,
    required this.error,
    required this.userProfile,
  });

  factory ProfileEditState.initial() {
    return ProfileEditState(
      status: StateType.initial,
      error: null,
      userProfile: UserProfile.empty(),
    );
  }

  ProfileEditState copyWith({
    StateType? status,
    String? error,
    UserProfile? userProfile,
  }) {
    return ProfileEditState(
      status: status ?? this.status,
      error: error ?? this.error,
      userProfile: userProfile ?? this.userProfile,
    );
  }

  @override
  List<Object?> get props => [status, error, userProfile];
}
