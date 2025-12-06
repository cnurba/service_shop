import 'package:flutter/material.dart';
import 'package:service_shop/app/profile/presentation/widgets/payment_card_item.dart';
import 'package:service_shop/core/presentation/appbar/custom_appbar.dart';
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
      appBar: customAppBar(context, "Способы оплаты", showBack: false),

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
