import 'package:flutter/material.dart';
import 'package:service_shop/auth/presentation/screens/register_pages/registration_screen.dart';
import 'package:service_shop/auth/presentation/widgets/auth_container.dart';
import 'package:service_shop/core/extansions/router_extension.dart';
import 'package:service_shop/core/presentation/appbar/login_appbar.dart';
import 'package:service_shop/core/presentation/buttons/custom_button.dart';
import 'package:service_shop/core/presentation/fields/password_field.dart';
import 'package:service_shop/core/presentation/fields/phone_field.dart';
import 'package:service_shop/core/presentation/theme/colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final authController = ref.watch(authControllerProvider);

    return Scaffold(
      backgroundColor: ServiceColors.primaryColor,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LoginAppbar(),
            SizedBox(height: 24),
            AuthContainer(
              title: 'Вход в аккаунт',
              subtitle:
                  'Введите номер телефона и пароль, чтобы продолжить покупки',
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      PhoneField(onChanged: (value) {}),
                      PasswordField(onChanged: (value) {}, title: "Пароль"),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Забыли пароль?',
                              style: TextStyle(
                                color: ServiceColors.primaryColor,
                              ),
                            ),
                            GestureDetector(
                              onTap: () => context.push(RegistrationScreen()),
                              child: Text(
                                'Регистрация',
                                style: TextStyle(
                                  color: ServiceColors.primaryColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 22),
                      CustomButton(
                        text: 'Войти',
                        width: MediaQuery.sizeOf(context).width*0.8,
                        height: 35,
                        onPressed: () {},
                      ),
                      SizedBox(height: 20),
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
