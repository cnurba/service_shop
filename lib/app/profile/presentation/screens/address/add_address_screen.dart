import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:service_shop/app/basket/application/add_order/add_order_controller.dart';
import 'package:service_shop/app/basket/application/checkout_provider/checkout_controller.dart';
import 'package:service_shop/app/basket/presentation/section/address_storage.dart';
import 'package:service_shop/core/presentation/appbar/custom_appbar.dart';

class AddAddressScreen extends StatefulWidget {
  const AddAddressScreen({
    super.key,
    required this.onNameChanged,
    required this.onNamePhone,
    required this.onCityChanged,
    required this.onStreetChanged,
    required this.onApartmentChanged,
    required this.onSaveInfoChanged,
  });

  final Function(String name) onNameChanged;
  final Function(String phone) onNamePhone;
  final Function(String city) onCityChanged;
  final Function(String street) onStreetChanged;
  final Function(String apartment) onApartmentChanged;
  final Function(bool saveInfo) onSaveInfoChanged;

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  late bool _isChecked;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadSavedAddress();
  }

  Future<void> _loadSavedAddress() async {
    final saved = await AddressStorage.loadSavedAddress();
    if (mounted) {
      setState(() {
        _isChecked = saved['saveInfo'] as bool;
        _isLoading = false;
      });

      // Pre-fill fields if saved
      if (_isChecked) {
        widget.onNameChanged(saved['name'] as String);
        widget.onNamePhone(saved['phone'] as String);
        widget.onCityChanged(saved['city'] as String);
        widget.onStreetChanged(saved['street'] as String);
        widget.onApartmentChanged(saved['apartment'] as String);
        widget.onSaveInfoChanged(true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      appBar: customAppBar(context, 'Адрес'),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Адрес и контактные данные',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 16),

              TextField(
                // onChanged: widget.onNameChanged,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Имя',
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                onChanged: widget.onNamePhone,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Телефон',
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                onChanged: widget.onCityChanged,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Город, область',
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                onChanged: widget.onStreetChanged,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Улица',
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                onChanged: widget.onApartmentChanged,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Дом, квартира',
                ),
              ),
              const SizedBox(height: 16),
              // Row(
              //   children: [
              //     Checkbox(
              //       value: _isChecked,
              //       onChanged: (value) {
              //         setState(() => _isChecked = value ?? false);
              //         widget.onSaveInfoChanged(_isChecked);

              //         if (!_isChecked) {
              //           AddressStorage.clearAddress(); // Clear if unchecked
              //         }
              //       },
              //     ),
              //     const Expanded(
              //       child: Text('Сохранить эти данные для будущих заказов'),
              //     ),
              //   ],
              // ),
              Consumer(
                builder: (BuildContext context, WidgetRef ref, Widget? child) {
                  return TextButton(
                    onPressed: () async {
                      final checkoutState = ref.read(checkoutProvider);

                      // Save address if user checked "Save info"
                      if (checkoutState.saveInfo) {
                        await AddressStorage.saveAddress(
                          name: checkoutState.name,
                          phone: checkoutState.phone,
                          city: checkoutState.city,
                          street: checkoutState.street,
                          apartment: checkoutState.apartment,
                          saveInfo: true,
                        );
                      }

                      ref.read(addOrderProvider.notifier).post(checkoutState);
                    },
                    child: Text('Coхранить'),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
