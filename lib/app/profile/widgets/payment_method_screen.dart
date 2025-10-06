import 'package:flutter/material.dart';
import 'package:service_shop/core/presentation/theme/colors.dart';

class PaymentMethodScreen extends StatelessWidget {
  const PaymentMethodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<PaymentCard> cards = [
      PaymentCard(brand: 'Элкарт', number: '9417 **** **** 2687'),
      PaymentCard(brand: 'Visa', number: '4862 **** **** 9021'),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Способы оплаты'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: ServiceColors.primaryColor),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Карты',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: ServiceColors.primaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),

            ...cards.map(
              (card) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: PaymentCardItem(
                  card: card,
                  isSelected: card.brand == 'Элкарт',
                  onChanged: (value) {},
                ),
              ),
            ),

            const Divider(height: 32),

            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(
                Icons.credit_card_outlined,
                color: ServiceColors.primaryColor,
              ),
              title: const Text(
                'Добавить карту',
                style: TextStyle(
                  color: ServiceColors.primaryColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              trailing: IconButton(
                icon: const Icon(
                  Icons.add_circle_outline,
                  color: ServiceColors.primaryColor,
                ),
                onPressed: () {},
              ),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}

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
