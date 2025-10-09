import 'package:flutter/material.dart';
import 'package:service_shop/auth/presentation/widgets/auth_container.dart';
import 'package:service_shop/core/presentation/appbar/login_appbar.dart';
import 'package:service_shop/core/presentation/buttons/custom_button.dart';
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
                  child: Column(
                    children: [
                      TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(
                          labelText: 'Номер телефона',
                          prefixText: '+996',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Пожалуйста, введите адрес электронной почты';
                          } else if (value.length < 4) {
                            return 'Пожалуйста, введите не менее 4 символов';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: passwordController,
                        decoration: InputDecoration(
                          labelText: 'Пароль',
                          suffixIcon: Icon(Icons.remove_red_eye_outlined),
                          border: OutlineInputBorder(),
                        ),
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Пожалуйста, введите пароль';
                          } else if (value.length < 3) {
                            return 'Пожалуйста, введите не менее 3 символов';
                          }
                          return null;
                        },
                      ),
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
                            Text(
                              'Регистрация',
                              style: TextStyle(
                                color: ServiceColors.primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 22),
                      CustomButton(
                        text: 'Войти',
                        width: 322,
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
