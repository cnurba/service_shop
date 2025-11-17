import 'package:flutter/material.dart';
import 'package:service_shop/auth/presentation/screens/resign_withnumber.dart';
import 'package:service_shop/auth/presentation/widgets/auth_container.dart';
import 'package:service_shop/core/extansions/router_extension.dart';
import 'package:service_shop/core/presentation/appbar/login_appbar.dart';
import 'package:service_shop/core/presentation/buttons/custom_button.dart';
import 'package:service_shop/core/presentation/theme/colors.dart';

class ResignWithemailScreen extends StatefulWidget {
  const ResignWithemailScreen({super.key});

  @override
  State<ResignWithemailScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<ResignWithemailScreen> {
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
              title: 'Забыли пароль?',
              subtitle:
                  'Введите адрес электронной почты, привязанный \nк вашему аккаунту.\nМы отправим код для восстановления пароля.',
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Form(
                      child: Column(
                        children: [
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'E-mail',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 8),
                          GestureDetector(
                            onTap: () => context.push(ResignWithnumberScreen()),
                            child: Text('Восстановить по номеру телефона'),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 22),
                  CustomButton(
                    text: 'Отправить',
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
