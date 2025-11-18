import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Address {
  final String title;
  final String address;
  final bool isDefault;

  const Address(this.title, this.address, [this.isDefault = false]);
}

class AddressCard extends StatelessWidget {
  final Address address;
  const AddressCard({super.key, required this.address});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            address.title,
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
          const SizedBox(height: 4),
          Text(
            address.address,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: theme.primaryColor),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                  ),
                  child: Text(
                    address.isDefault ? 'По умолчанию' : 'Сделать основным',
                    style: TextStyle(color: theme.primaryColor),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                  ),
                  child: const Text('Изменить адрес'),
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.delete_outline,
                  color: Colors.red,
                  size: 28,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
