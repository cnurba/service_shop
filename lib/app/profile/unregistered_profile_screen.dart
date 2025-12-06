import 'package:flutter/material.dart';
import 'package:service_shop/app/profile/presentation/screens/about_app_screen.dart';
import 'package:service_shop/app/profile/presentation/screens/feedback_screen.dart';
import 'package:service_shop/app/profile/presentation/screens/settings_screen.dart';
import 'package:service_shop/app/profile/presentation/widgets/profile_menu_tile.dart';
import 'package:service_shop/auth/presentation/screens/login_screen.dart';
import 'package:service_shop/auth/presentation/screens/register_pages/registration_screen.dart';
import 'package:service_shop/core/extansions/router_extension.dart';
import 'package:service_shop/core/presentation/appbar/custom_appbar.dart';
import 'package:service_shop/core/presentation/theme/colors.dart';

class UnregisteredProfileScreen extends StatefulWidget {
  const UnregisteredProfileScreen({super.key});

  @override
  State<UnregisteredProfileScreen> createState() =>
      _UnregisteredProfileScreenState();
}

class _UnregisteredProfileScreenState extends State<UnregisteredProfileScreen> {
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
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 18),
            Image.asset('assets/img/buy.png'),
            Text(
              'Войдите в свой профиль',
              style: TextTheme.of(context).titleMedium,
            ),
            SizedBox(height: 8),
            Text(
              'Чтобы покупать товары',
              style: TextStyle(color: ServiceColors.grey),
            ),
            SizedBox(height: 14),
            GestureDetector(
              onTap: () => context.push(LoginScreen()),
              child: Container(
                width: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: ServiceColors.primaryColor),
                ),
                child: Row(
                  children: [
                    Image.asset('assets/img/login.png'),
                    Text(
                      'Войти',
                      style: TextStyle(color: ServiceColors.primaryColor),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            GestureDetector(
              onTap: () => context.push(RegistrationScreen()),
              child: Container(
                width: 214,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: ServiceColors.primaryColor),
                ),
                alignment: Alignment.center,
                child: Text(
                  'Регистрация аккаунта',
                  style: TextStyle(color: ServiceColors.primaryColor),
                ),
              ),
            ),
            SizedBox(height: 16),
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
