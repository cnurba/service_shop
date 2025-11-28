import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:service_shop/app/profile/application/adress/my_address_provider.dart';
import 'package:service_shop/app/profile/application/new_address/new_address_provider.dart';
import 'package:service_shop/core/enum/state_type.dart';
import 'package:service_shop/core/presentation/appbar/custom_appbar.dart';
import 'package:service_shop/core/presentation/buttons/custom_button.dart';

class NewAddressScreen extends ConsumerStatefulWidget {
  const NewAddressScreen({super.key});

  @override
  ConsumerState<NewAddressScreen> createState() => _NewAddressScreenState();
}

class _NewAddressScreenState extends ConsumerState<NewAddressScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final newAddress = ref.watch(newAddressProvider);

    if (newAddress.stateType == StateType.loading) {
      return const CircularProgressIndicator();
    }
    return Scaffold(
      appBar: customAppBar(context, 'Изменить адрес'),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Text(
                'Адрес и контактные данные',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 16),

              /// NAME
              TextFormField(
                initialValue: ref.watch(newAddressProvider).name,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Введите имя';
                  } else if (value.length < 3) {
                    return 'Имя слишком короткое';
                  }
                  return null;
                },
                onChanged: (value) =>
                    ref.read(newAddressProvider.notifier).updateName(value),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Имя',
                ),
              ),
              const SizedBox(height: 8),

              /// PHONE
              TextFormField(
                initialValue: ref.watch(newAddressProvider).phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Введите телефон';
                  } else if (value.length < 10) {
                    return 'Телефон слишком короткий';
                  } else if (!RegExp(r'^\+?\d{10,15}$').hasMatch(value)) {
                    return 'Некорректный формат телефона';
                  }
                  return null;
                },
                keyboardType: TextInputType.phone,
                onChanged: (value) =>
                    ref.read(newAddressProvider.notifier).updatePhone(value),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Телефон',
                ),
              ),
              const SizedBox(height: 16),

              /// CITY
              TextFormField(
                initialValue: ref.watch(newAddressProvider).city,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Введите город';
                  } else if (value.length < 2) {
                    return 'Название города слишком короткое';
                  }
                  return null;
                },
                onChanged: (value) =>
                    ref.read(newAddressProvider.notifier).updateCity(value),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Город, область',
                ),
              ),
              const SizedBox(height: 8),

              /// STREET
              TextFormField(
                initialValue: ref.watch(newAddressProvider).street,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Введите улицу';
                  } else if (value.length < 3) {
                    return 'Название улицы слишком короткое';
                  }
                  return null;
                },
                onChanged: (value) =>
                    ref.read(newAddressProvider.notifier).updateStreet(value),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Улица, дом',
                ),
              ),
              const SizedBox(height: 8),

              /// APARTMENT
              TextFormField(
                initialValue: ref.watch(newAddressProvider).apartment,
                validator: (value) =>
                    value == null || value.isEmpty ? 'Введите квартиру' : null,
                onChanged: (value) => ref
                    .read(newAddressProvider.notifier)
                    .updateApartment(value),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Квартира, офис и т.д.',
                ),
              ),
              const SizedBox(height: 16),

              CustomButton(
                text: 'Сохранить адрес',
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await ref.read(newAddressProvider.notifier).save();

                    final state = ref.watch(newAddressProvider);

                    if (state.stateType == StateType.loaded) {
                      // ref.read(myAddressProvider.notifier).loadAddresses();

                      Navigator.pop(context);
                    } else if (state.stateType == StateType.error) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Произошла ошибка")),
                      );
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
