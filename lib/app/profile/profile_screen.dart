import 'package:flutter/material.dart';
import 'package:service_shop/app/profile/profile_edit_screen.dart';
import 'package:service_shop/app/profile/screens/about_app_screen.dart';
import 'package:service_shop/app/profile/screens/feedback_screen.dart';
import 'package:service_shop/app/profile/screens/my_adress_screen.dart';
import 'package:service_shop/app/profile/screens/order_history_screen.dart';
import 'package:service_shop/app/profile/screens/payment_method_screen.dart';
import 'package:service_shop/app/profile/screens/settings_screen.dart';
import 'package:service_shop/app/profile/widgets/profile_menu_tile.dart';
import 'package:service_shop/app/profile/widgets/status_container.dart';
import 'package:service_shop/core/extansions/router_extension.dart';
import 'package:service_shop/core/presentation/appbar/custom_appbar.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context,
        "Профиль",
        showBack: false,
        actions: [
          IconButton(icon: const Icon(Icons.notifications), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: const [
                CircleAvatar(radius: 30, child: Icon(Icons.person, size: 30)),
                SizedBox(width: 12),
                Text(
                  "Айбек Жапаров",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ProfileEditScreen()),
                );
              },
              child: StatusContainer(text: 'Редактировать профиль'),
            ),
            const SizedBox(height: 16),

            ProfileMenuTile(
              title: "История заказов",
              icon: Icons.task_outlined,
              onTap: () => context.push(OrderHistoryScreen()),
            ),
            ProfileMenuTile(
              title: "Мои адреса",
              icon: Icons.location_on_outlined,
              onTap: () => context.push(MyAddressesScreen()),
            ),
            ProfileMenuTile(
              title: "Способы оплаты",
              icon: Icons.wallet_outlined,
              onTap: () => context.push(PaymentMethodScreen()),
            ),
            ProfileMenuTile(
              title: "Обратная связь",
              icon: Icons.feedback_outlined,
              onTap: () => context.push(FeedbackScreen()),
            ),
            ProfileMenuTile(
              title: "О приложении",
              icon: Icons.info_outline,
              onTap: () => context.push(AboutAppScreen()),
            ),
            ProfileMenuTile(
              title: "Настройки",
              icon: Icons.settings_outlined,
              onTap: () => context.push(SettingsScreen()),
            ),
          ],
        ),
      ),
    );
  }
}
