import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:service_shop/app/profile/domain/models/user_edit_model.dart';
import 'package:service_shop/app/profile/domain/repositories/i_profile_repository.dart';
import 'package:service_shop/app/profile/infrastructure/repositories/profile_repository.dart';
import 'package:service_shop/injection.dart';

final currentUserRepositoryProvider = Provider<IProfileRepository>(
  (ref) => ProfileRepository(getIt<Dio>(),getIt()),
);

final currentUserProvider = FutureProvider.autoDispose<UserProfile>((
  ref,
) async {
  final profileRepository = ref.watch(currentUserRepositoryProvider);
  final result = await profileRepository.getCurrentUser();
  return result;
});
