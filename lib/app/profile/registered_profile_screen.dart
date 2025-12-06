import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:service_shop/app/profile/domain/models/user_edit_model.dart';
import 'package:service_shop/app/profile/presentation/screens/about_app_screen.dart';
import 'package:service_shop/app/profile/presentation/screens/address/my_adress_screen.dart';
import 'package:service_shop/app/profile/presentation/screens/feedback_screen.dart';
import 'package:service_shop/app/profile/presentation/screens/order_history_screen.dart';
import 'package:service_shop/app/profile/presentation/screens/payment_method_screen.dart';
import 'package:service_shop/app/profile/presentation/screens/settings_screen.dart';
import 'package:service_shop/app/profile/presentation/widgets/profile_menu_tile.dart';
import 'package:service_shop/app/profile/presentation/widgets/status_container.dart';
import 'package:service_shop/app/profile/profile_edit_screen.dart';
import 'package:service_shop/core/extansions/router_extension.dart';
import 'package:service_shop/core/presentation/appbar/custom_appbar.dart';
import 'package:service_shop/core/presentation/image/app_image_container.dart';

import 'application/profile_edit/profile_edit_provider.dart';

class RegisteredProfileScreen extends StatelessWidget {
  const RegisteredProfileScreen({super.key, required this.profile});

  final UserProfile profile;

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
              children: [
                CircleAvatar(
                  radius: 30,
                  child: AppImageContainer(image: profile.imageUrl),
                ),
                SizedBox(width: 12),
                Text(
                  profile.fullName,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 8),

            Consumer(
              builder: (context, ref, child) {
                return GestureDetector(
                  onTap: () {
                    ref
                        .read(profileEditProvider.notifier)
                        .setUserProfile(profile);
                    context.push(ProfileEditScreen());
                  },
                  child: StatusContainer(text: 'Редактировать профиль'),
                );
              },
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
