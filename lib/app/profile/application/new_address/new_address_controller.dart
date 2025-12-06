import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:service_shop/app/profile/application/new_address/new_address_state.dart';
import 'package:service_shop/app/profile/domain/models/my_address.dart';
import 'package:service_shop/app/profile/domain/repositories/i_profile_repository.dart';
import 'package:service_shop/core/enum/state_type.dart';

class NewAddressController extends StateNotifier<NewAddressState> {
  NewAddressController(this.repository) : super(NewAddressState.initial());

  final IProfileRepository repository;

  void updateName(String name) {
    state = state.copyWith(name: name);
  }

  void updatePhone(String phone) {
    state = state.copyWith(phone: phone);
  }

  void updateCity(String city) {
    state = state.copyWith(city: city);
  }

  void updateStreet(String street) {
    state = state.copyWith(street: street);
  }

  void updateApartment(String apartment) {
    state = state.copyWith(apartment: apartment);
  }

  void initalize(MyAddressModel address) {
    state = state.copyWith(
      name: address.name,
      phone: address.phone,
      city: address.city,
      street: address.street,
      apartment: address.apartment,
    );
  }

  Future<void> save() async {
    state = state.copyWith(stateType: StateType.loading);
    try {
      final address = MyAddressModel(
        id: state.id,
        name: state.name,
        phone: state.phone,
        city: state.city,
        street: state.street,
        apartment: state.apartment,
      );

      final result = await repository.addNewAddress(address);

      if (result == true) {
        state = state.copyWith(stateType: StateType.loaded);
      } else {
        state = state.copyWith(stateType: StateType.error);
      }
    } catch (e) {
      state = state.copyWith(stateType: StateType.error);
    }
  }
}
