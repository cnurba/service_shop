import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:service_shop/app/profile/application/adress/my_address_controller.dart';
import 'package:service_shop/app/profile/application/adress/my_address_state.dart';
import 'package:service_shop/app/profile/domain/repositories/i_profile_repository.dart';
import 'package:service_shop/injection.dart';

final myAddressProvider =
    StateNotifierProvider<MyAddressController, MyAddressState>((ref) {
      return MyAddressController(getIt<IProfileRepository>());
    });
