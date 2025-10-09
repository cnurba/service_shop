import 'package:flutter/material.dart';
import 'package:service_shop/app/profile/widgets/feedback_contact_tile.dart';
import 'package:service_shop/app/profile/widgets/feedback_section_tile.dart';
import 'package:service_shop/app/profile/widgets/faq_card.dart';
import 'package:service_shop/core/presentation/appbar/custom_appbar.dart';

class FeedbackScreen extends StatelessWidget {
  const FeedbackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final faqs = [
      'Где посмотреть статус моего заказа?',
      'Можно ли объединить несколько заказов в одну доставку?',
      'Можно ли оплатить заказ при получении?',
      'Как оформить покупку в рассрочку/в долг (для договорных клиентов)?',
      'Как изменить номер телефона или адрес доставки?',
    ];

    return Scaffold(
      appBar: customAppBar(context, "Обратная связь", showBack: false),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionTitle(title: 'Часто задаваемые вопросы'),
            const SizedBox(height: 8),
            FaqCard(faqs: faqs),
            const SizedBox(height: 24),
            SectionTitle(title: 'Способы связи'),
            const SizedBox(height: 8),
            ContactTile(
              icon: Icons.phone,
              label: '+996 555 54 54 54',
              onTap: () {},
            ),
            const SizedBox(height: 10),
            ContactTile(
              icon: Icons.facebook,
              label: 'Написать в WhatsApp',
              onTap: () {},
            ),
            const SizedBox(height: 10),
            ContactTile(
              icon: Icons.telegram,
              label: '@sservice_market',
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
