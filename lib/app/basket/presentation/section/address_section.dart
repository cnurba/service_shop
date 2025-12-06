// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:service_shop/app/basket/application/checkout_provider/checkout_controller.dart';
// import 'package:service_shop/app/basket/presentation/section/address_storage.dart';
// import 'package:service_shop/app/profile/domain/models/my_address.dart';
// import 'package:service_shop/app/profile/presentation/screens/address/my_adress_screen.dart';
// import 'package:service_shop/app/profile/presentation/screens/address/new_address_screen.dart';
// import 'package:service_shop/core/extansions/router_extension.dart';

// class AddressSection extends StatefulWidget {
//   const AddressSection({
//     super.key,
//     required this.onNameChanged,
//     required this.onNamePhone,
//     required this.onCityChanged,
//     required this.onStreetChanged,
//     required this.onApartmentChanged,
//     required this.onSaveInfoChanged,
//   });

//   final Function(String name) onNameChanged;
//   final Function(String phone) onNamePhone;
//   final Function(String city) onCityChanged;
//   final Function(String street) onStreetChanged;
//   final Function(String apartment) onApartmentChanged;
//   final Function(bool saveInfo) onSaveInfoChanged;

//   @override
//   State<AddressSection> createState() => _AddressSectionState();
// }

// class _AddressSectionState extends State<AddressSection> {
//   // late bool _isChecked;
//   // bool _isLoading = true;

//   // @override
//   // void initState() {
//   //   super.initState();
//   //   _loadSavedAddress();
//   // }

//   // Future<void> _loadSavedAddress() async {
//   //   final saved = await AddressStorage.loadSavedAddress();
//   //   if (mounted) {
//   //     setState(() {
//   //       _isChecked = saved['saveInfo'] as bool;
//   //       _isLoading = false;
//   //     });

//   //     // Pre-fill fields if saved
//   //     if (_isChecked) {
//   //       widget.onNameChanged(saved['name'] as String);
//   //       widget.onNamePhone(saved['phone'] as String);
//   //       widget.onCityChanged(saved['city'] as String);
//   //       widget.onStreetChanged(saved['street'] as String);
//   //       widget.onApartmentChanged(saved['apartment'] as String);
//   //       widget.onSaveInfoChanged(true);
//   //     }
//   //   }
//   // }

//   @override
//   Widget build(BuildContext context) {
//     MyAddressModel? _selectedAddress;
//     // if (_isLoading) {
//     //   return const Center(child: CircularProgressIndicator());
//     // }

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'Адрес и контактные данные',
//           style: Theme.of(context).textTheme.titleMedium,
//         ),
//         const SizedBox(height: 16),
//         Consumer(
//           builder: (context, ref, _) {
//             return _selectedAddress == null
//                 ? TextButton(
//                     onPressed: () async {
//                       final selectedAddress = await Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (_) => MyAddressesScreen()),
//                       );

//                       if (selectedAddress != null) {
//                         setState(() {
//                           _selectedAddress = selectedAddress;
//                         });

//                         ref
//                             .read(checkoutProvider.notifier)
//                             .onChangeName(selectedAddress.name);
//                         ref
//                             .read(checkoutProvider.notifier)
//                             .onChangePhone(selectedAddress.phone);
//                         ref
//                             .read(checkoutProvider.notifier)
//                             .onChangeCity(selectedAddress.city);
//                         ref
//                             .read(checkoutProvider.notifier)
//                             .onChangeStreet(selectedAddress.street);
//                         ref
//                             .read(checkoutProvider.notifier)
//                             .onChangeApartment(selectedAddress.apartment);
//                       }
//                     },
//                     child: Text('Выберите адрес'),
//                   )
//                 : _buildSelectedAddressCard(_selectedAddress!);
//           },
//         ),

//         // Row(
//         //   children: [
//         //     Expanded(
//         //       child: TextField(
//         //         // onChanged: widget.onNameChanged,
//         //         decoration: const InputDecoration(
//         //           border: OutlineInputBorder(),
//         //           hintText: 'Имя',
//         //         ),
//         //       ),
//         //     ),
//         //     const SizedBox(width: 8),
//         //     Expanded(
//         //       child: TextField(
//         //         onChanged: widget.onNamePhone,
//         //         decoration: const InputDecoration(
//         //           border: OutlineInputBorder(),
//         //           hintText: 'Телефон',
//         //         ),
//         //       ),
//         //     ),
//         //   ],
//         // ),
//         // const SizedBox(height: 16),
//         // Row(
//         //   children: [
//         //     Expanded(
//         //       child: TextField(
//         //         onChanged: widget.onCityChanged,
//         //         decoration: const InputDecoration(
//         //           border: OutlineInputBorder(),
//         //           hintText: 'Город, область',
//         //         ),
//         //       ),
//         //     ),
//         //     const SizedBox(width: 8),
//         //     Expanded(
//         //       child: TextField(
//         //         onChanged: widget.onStreetChanged,
//         //         decoration: const InputDecoration(
//         //           border: OutlineInputBorder(),
//         //           hintText: 'Улица',
//         //         ),
//         //       ),
//         //     ),
//         //     const SizedBox(width: 8),
//         //     Expanded(
//         //       child: TextField(
//         //         onChanged: widget.onApartmentChanged,
//         //         decoration: const InputDecoration(
//         //           border: OutlineInputBorder(),
//         //           hintText: 'Дом, квартира',
//         //         ),
//         //       ),
//         //     ),
//         //   ],
//         // ),
//         // const SizedBox(height: 16),
//         // Row(
//         //   children: [
//         //     Checkbox(
//         //       value: _isChecked,
//         //       onChanged: (value) {
//         //         setState(() => _isChecked = value ?? false);
//         //         widget.onSaveInfoChanged(_isChecked);

//         //         if (!_isChecked) {
//         //           AddressStorage.clearAddress(); // Clear if unchecked
//         //         }
//         //       },
//         //     ),
//         //     const Expanded(
//         //       child: Text('Сохранить эти данные для будущих заказов'),
//         //     ),
//         //   ],
//         // ),
//       ],
//     );
//   }
// }

// Widget _buildSelectedAddressCard(MyAddressModel address) {
//   return Container(
//     padding: EdgeInsets.all(12),
//     decoration: BoxDecoration(
//       borderRadius: BorderRadius.circular(8),
//       border: Border.all(color: Colors.grey.shade300),
//     ),
//     child: Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(address.name, style: TextStyle(fontWeight: FontWeight.bold)),
//         Text(address.phone),
//         Text("${address.city}, ${address.street}"),
//         Text("Квартира: ${address.apartment}"),
//       ],
//     ),
//   );
// }
