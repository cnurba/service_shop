import 'package:flutter/material.dart';
import 'package:service_shop/core/presentation/theme/colors.dart';

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
      appBar: AppBar(
        title: const Text('Обратная связь'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: ServiceColors.primaryColor),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// --- FAQ SECTION ---
            SectionTitle(title: 'Часто задаваемые вопросы'),
            const SizedBox(height: 8),
            Card(
              color: ServiceColors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: faqs.length,
                separatorBuilder: (_, __) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      faqs[index],
                      style: const TextStyle(fontSize: 15),
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 18,
                      color: Colors.grey,
                    ),
                    onTap: () {
                      // TODO: Navigate to FAQ detail or open a dialog
                    },
                  );
                },
              ),
            ),

            const SizedBox(height: 24),

            /// --- CONTACT SECTION ---
            SectionTitle(title: 'Способы связи'),
            const SizedBox(height: 8),

            ContactTile(
              icon: Icons.phone,
              label: '+996 555 54 54 54',
              onTap: () {
                // TODO: Make a call
              },
            ),
            const SizedBox(height: 10),
            ContactTile(
              icon: Icons.facebook,
              label: 'Написать в WhatsApp',
              onTap: () {
                // TODO: Open WhatsApp
              },
            ),
            const SizedBox(height: 10),
            ContactTile(
              icon: Icons.telegram,
              label: '@sservice_market',
              onTap: () {
                // TODO: Open Telegram
              },
            ),
          ],
        ),
      ),
    );
  }
}

/// Section title widget
class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
        color: ServiceColors.primaryColor,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}

/// Contact info widget
class ContactTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const ContactTile({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: ServiceColors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          children: [
            Icon(icon, color: ServiceColors.primaryColor),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                label,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 16,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
