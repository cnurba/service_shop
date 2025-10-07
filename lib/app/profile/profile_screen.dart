import 'package:flutter/material.dart';
import 'package:service_shop/app/profile/profile_edit_screen.dart';
import 'package:service_shop/app/profile/widgets/about_app_screen.dart';
import 'package:service_shop/app/profile/widgets/feedback_screen.dart';
import 'package:service_shop/app/profile/widgets/my_adress_screen.dart';
import 'package:service_shop/app/profile/widgets/order_history_screen.dart';
import 'package:service_shop/app/profile/widgets/payment_method_screen.dart';
import 'package:service_shop/app/profile/widgets/settings_screen.dart';
import 'package:service_shop/core/extansions/router_extension.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Профиль"),
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
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  "Редактировать профиль",
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
              ),
            ),
            const SizedBox(height: 16),
            ListTile(
              title: const Text("История заказов"),
              leading: Icon(Icons.task_outlined),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => OrderHistoryScreen()),
                );
              },
            ),

            ListTile(
              title: const Text("Мои адреса"),
              leading: Icon(Icons.location_on_outlined),
              onTap: () {
                context.push(MyAddressesScreen());
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => MyAddressesScreen()),
                // );
              },
            ),
            ListTile(
              title: Text('Способы оплаты'),
              leading: Icon(Icons.wallet_outlined),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PaymentMethodScreen(),
                  ),
                );
              },
            ),
            ListTile(
              title: Text('Покупки'),
              leading: Icon(Icons.insert_drive_file_outlined),
            ),
            ListTile(
              title: Text('Обратная связь'),
              leading: Icon(Icons.feedback_outlined),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FeedbackScreen()),
                );
              },
            ),

            ListTile(
              title: Text('О приложении'),
              leading: Icon(Icons.info_outline),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AboutAppScreen()),
                );
              },
            ),
            ListTile(
              title: Text('Настройки'),
              leading: Icon(Icons.settings_outlined),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingsScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
