import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:service_shop/app/profile/application/add_address/add_address_state.dart';
import 'package:service_shop/app/profile/domain/repositories/i_profile_repository.dart';

class AddAddressController extends StateNotifier<AddAddressState> {
  final IProfileRepository repository;

  AddAddressController(this.repository) : super(const AddAddressState());
}
