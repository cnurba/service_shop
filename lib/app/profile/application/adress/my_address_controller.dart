import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:service_shop/app/profile/application/adress/my_address_state.dart';
import 'package:service_shop/app/profile/domain/repositories/i_profile_repository.dart';
import 'package:service_shop/core/enum/state_type.dart';

class MyAddressController extends StateNotifier<MyAddressState> {
  final IProfileRepository repository;
  MyAddressController(this.repository) : super(const MyAddressState());

  Future<void> loadAddresses() async {
    state = state.copyWith(status: StateType.loading, error: null);
    try {
      final address = await repository.getMyAddress();
      state = state.copyWith(addresses: address, status: StateType.loaded);
    } catch (e) {
      state = state.copyWith(status: StateType.error, error: e.toString());
    }
  }
}
