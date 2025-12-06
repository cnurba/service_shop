import 'package:flutter/material.dart';
import 'package:service_shop/app/profile/presentation/widgets/faq_expansion_tile.dart';
import 'package:service_shop/app/profile/presentation/widgets/feedback_contact_tile.dart';
import 'package:service_shop/app/profile/presentation/widgets/feedback_section_tile.dart';
import 'package:service_shop/core/presentation/appbar/custom_appbar.dart';
import 'package:service_shop/core/utils/url_helpers.dart';
import 'package:url_launcher/url_launcher.dart';

class FeedbackScreen extends StatelessWidget {
  const FeedbackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Questions & answers
    final faqs = [
      {
        'question': 'Где посмотреть статус моего заказа?',
        'answer':
            'Статус заказа можно посмотреть в разделе Профиль → История заказов.\n\nТам отображаются этапы:\nВ обработке\nВ пути\nДоставлен\n\nТакже вы можете нажать на товар, чтобы увидеть детали.',
        'boldText': [
          'Профиль',
          'История заказов',
          'В обработке',
          'В пути',
          'Доставлен',
        ],
      },
      {
        'question': 'Можно ли объединить несколько заказов в одну доставку?',
        'answer':
            'Сейчас заказы из разных магазинов доставляются отдельно, так как отправляются напрямую от каждого продавца.\n\nОднако при оформлении можно выбрать вариант «Объединённая доставка» — если товары доступны для совместной отправки. Этот способ может занять больше времени и стоить немного дороже.',
        'boldText': ['отдельно', 'Объединённая доставка'],
      },
      {
        'question': 'Можно ли оплатить заказ при получении?',
        'answer':
            'Да, если продавец поддерживает такую опцию.\n\nПри оформлении заказа выберите «Наличными».\n\nЕсли этот вариант недоступен — оплату нужно внести онлайн через систему.',
        'boldText': ['Наличными'],
      },
      {
        'question': 'Как оформить покупку в рассрочку?',
        'answer':
            'Покупка в рассрочку доступна только для клиентов, заключивших договор.\n\nЕсли вы хотите подключить этот вариант — свяжитесь с менеджером (внизу способы связи)',
        'boldText': [''],
      },
      {
        'question': 'Как изменить номер телефона или адрес доставки?',
        'answer':
            'Изменить номер телефона можно в разделе Профиль → Мои данные → Редактировать профиль.\nТам вы сможете:\nОбновить номер телефона\nДобавить электронную почту\n\nАдрес доставки можно изменить в разделе Профиль → Мои адреса.\nТам вы сможете:\nДобавить новый адрес\nСделать основным адресом доставки\nУдалить другие адреса\n\nПосле сохранения изменений новые данные применятся к будущим заказам.',
        'boldText': [
          'Профиль',
          'Мои данные ',
          'Редактировать профиль.',
          'Профиль',
          'Мои адреса',
        ],
      },
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

            // 🧩 Render FAQ list
            ...faqs.map(
              (faq) => FaqExpansionTile(
                question: faq['question']! as String,
                answer: faq['answer']! as String,
                boldText: (faq['boldText'] as List<dynamic>?)
                    ?.map((e) => e.toString())
                    .toList(), // convert dynamic list to List<String>
              ),
            ),

            const SizedBox(height: 24),
            SectionTitle(title: 'Способы связи'),
            const SizedBox(height: 8),
            ContactTile(
              image: 'assets/img/call.png',
              label: '+996 555 54 54 54\n+996 705 54 54 54',
              onTap: () async {
                final phoneNumber = '+996555545454'; // choose one number
                final uri = Uri.parse('tel:$phoneNumber');
                if (await canLaunchUrl(uri)) {
                  await launchUrl(uri);
                }
              },
            ),
            const SizedBox(height: 10),
            ContactTile(
              image: 'assets/img/whatsapp.png',
              label: 'Написать в WhatsApp',
              onTap: () => openWhatsApp('996555545454', 'Здравствуйте!'),
            ),
            const SizedBox(height: 10),
            ContactTile(
              image: 'assets/img/instagram.png',
              label: '@sservice_market',
              onTap: () => openInstagram('sservice_market'),
            ),
          ],
        ),
      ),
    );
  }
}
