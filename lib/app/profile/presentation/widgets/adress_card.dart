import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:service_shop/app/profile/application/new_address/new_address_provider.dart';
import 'package:service_shop/app/profile/domain/models/my_address.dart';
import 'package:service_shop/app/profile/presentation/screens/address/new_address_screen.dart';
import 'package:service_shop/core/extansions/router_extension.dart';

class AddressCard extends StatefulWidget {
  final MyAddressModel address;
  const AddressCard({super.key, required this.address});

  @override
  State<AddressCard> createState() => _AddressCardState();
}

class _AddressCardState extends State<AddressCard> {
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
          Row(
            children: [
              Text('Адрес'),
              Text(
                widget.address.id,
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            widget.address.fullAddress,
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
                    widget.address.isDefault
                        ? 'По умолчанию'
                        : 'Сделать основным',
                    style: TextStyle(color: theme.primaryColor),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Consumer(
                  builder:
                      (BuildContext context, WidgetRef ref, Widget? child) {
                        return OutlinedButton(
                          onPressed: () {
                            ref
                                .read(newAddressProvider.notifier)
                                .initalize(widget.address);
                            context.push(const NewAddressScreen());
                          },
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                          ),
                          child: const Text('Изменить адрес'),
                        );
                      },
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
