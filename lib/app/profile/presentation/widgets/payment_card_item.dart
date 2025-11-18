import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:service_shop/core/presentation/theme/colors.dart';

class PaymentCard {
  final String brand;
  final String number;

  PaymentCard({required this.brand, required this.number});
}

class PaymentCardItem extends StatelessWidget {
  final PaymentCard card;
  final bool isSelected;
  final ValueChanged<bool?> onChanged;

  const PaymentCardItem({
    super.key,
    required this.card,
    required this.isSelected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ServiceColors.white,
        border: Border.all(
          color: isSelected ? ServiceColors.primaryColor : Colors.grey.shade300,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Row(
        children: [
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  card.brand,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  card.number,
                  style: const TextStyle(color: Colors.grey, fontSize: 13),
                ),
              ],
            ),
          ),
          Checkbox(
            value: isSelected,
            activeColor: ServiceColors.primaryColor,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
