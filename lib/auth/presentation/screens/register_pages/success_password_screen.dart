import 'package:flutter/material.dart';
import 'package:service_shop/auth/presentation/screens/login_screen.dart';
import 'package:service_shop/auth/presentation/screens/resign_withemail.dart';
import 'package:service_shop/auth/presentation/widgets/auth_container.dart';
import 'package:service_shop/core/extansions/router_extension.dart';
import 'package:service_shop/core/presentation/appbar/login_appbar.dart';
import 'package:service_shop/core/presentation/buttons/custom_button.dart';
import 'package:service_shop/core/presentation/theme/colors.dart';

class SuccessPasswordScreen extends StatefulWidget {
  const SuccessPasswordScreen({super.key});

  @override
  State<SuccessPasswordScreen> createState() => _SuccessPasswordScreenState();
}

class _SuccessPasswordScreenState extends State<SuccessPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ServiceColors.primaryColor,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            LoginAppbar(),
            SizedBox(height: 24),
            AuthContainer(
              title: 'Ваш пароль успешно изменён',
              subtitle: 'Теперь вы можете войти в приложение \nс новым паролем',
              icon: Icons.check_circle,
              child: Column(
                children: [
                  SizedBox(height: 22),

                  CustomButton(
                    text: 'Войти',
                    width: 322,
                    height: 35,
                    onPressed: () {
                      context.push(const LoginScreen());
                    },
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
