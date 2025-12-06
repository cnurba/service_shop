import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:service_shop/injection.dart';
import 'profile_edit_controller.dart';
import 'profile_edit_state.dart';

final profileEditProvider =
    StateNotifierProvider<ProfileEditController, ProfileEditState>(
      (ref) => ProfileEditController(getIt()),
    );
