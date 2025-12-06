import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:service_shop/app/profile/application/new_address/new_address_controller.dart';
import 'package:service_shop/app/profile/domain/repositories/i_profile_repository.dart';
import 'package:service_shop/injection.dart';

final newAddressProvider = StateNotifierProvider(
  (ref) => NewAddressController(getIt<IProfileRepository>()),
);
