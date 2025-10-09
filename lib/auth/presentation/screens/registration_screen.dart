import 'package:flutter/material.dart';
import 'package:service_shop/auth/presentation/widgets/auth_container.dart';
import 'package:service_shop/auth/presentation/widgets/custom_textfield.dart';
import 'package:service_shop/core/presentation/appbar/login_appbar.dart';
import 'package:service_shop/core/presentation/buttons/custom_button.dart';
import 'package:service_shop/core/presentation/theme/colors.dart';

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ServiceColors.primaryColor,
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const LoginAppbar(),
            const SizedBox(height: 24),
            AuthContainer(
              title: 'Регистрация',
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Form(
                  child: Column(
                    children: [
                      const CustomTextField(label: 'Фамилия'),
                      const SizedBox(height: 16),
                      const CustomTextField(label: 'Имя'),
                      const SizedBox(height: 16),
                      const CustomTextField(
                        label: 'Дата рождения',
                        suffixIcon: Icons.date_range,
                      ),
                      const SizedBox(height: 16),
                      const CustomTextField(
                        label: 'E-mail',
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 16),
                      const CustomTextField(
                        label: 'Номер телефона',
                        prefixText: '+996 ',
                        keyboardType: TextInputType.phone,
                      ),
                      const SizedBox(height: 22),
                      CustomButton(
                        text: 'Получить код',
                        width: 173,
                        height: 35,
                        onPressed: () {},
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
