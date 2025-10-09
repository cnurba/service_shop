import 'package:flutter/material.dart';
import 'package:service_shop/auth/presentation/widgets/auth_container.dart';
import 'package:service_shop/core/presentation/appbar/login_appbar.dart';
import 'package:service_shop/core/presentation/buttons/custom_button.dart';
import 'package:service_shop/core/presentation/theme/colors.dart';

class AddPasswordScreen extends StatefulWidget {
  const AddPasswordScreen({super.key});

  @override
  State<AddPasswordScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<AddPasswordScreen> {
  @override
  Widget build(BuildContext context) {
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
              title: 'Придумайте пароль',
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Form(
                      child: Column(
                        children: [
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Пароль',
                              suffixIcon: Icon(Icons.remove_red_eye),
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Используйте не менее 8 символов, с буквами и цифрами.',
                            style: TextStyle(
                              color: ServiceColors.primaryColor,
                              fontSize: 10,
                            ),
                          ),
                          const SizedBox(height: 16),

                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Подтверждения пароля',
                              suffixIcon: Icon(Icons.visibility_off),
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
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 22),
                  CustomButton(
                    text: 'Завершить регистрацию',
                    width: 322,
                    height: 35,
                    onPressed: () {},
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
