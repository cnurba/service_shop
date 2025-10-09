import 'package:flutter/material.dart';
import 'package:service_shop/app/profile/widgets/adress_card.dart';
import 'package:service_shop/core/presentation/appbar/custom_appbar.dart';

class MyAddressesScreen extends StatelessWidget {
  const MyAddressesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final addresses = [
      Address('Адрес 1', 'г. Ош, ул. Шакирова, 14а', true),
      Address('Адрес 2', 'г. Ош, ул. Кулатов, 184'),
    ];

    return Scaffold(
      appBar: customAppBar(context, "Мои адреса", showBack: false),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: ListView.separated(
                itemCount: addresses.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (_, i) => AddressCard(address: addresses[i]),
              ),
            ),
            const SizedBox(height: 12),
            OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.add, color: Colors.grey),
              label: const Text(
                'Добавить адрес',
                style: TextStyle(color: Colors.grey),
              ),
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: Colors.grey.shade300),
                minimumSize: const Size.fromHeight(56),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
