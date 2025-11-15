import 'package:flutter/material.dart';
import 'package:service_shop/auth/presentation/screens/resign_withemail.dart';
import 'package:service_shop/auth/presentation/widgets/auth_container.dart';
import 'package:service_shop/core/extansions/router_extension.dart';
import 'package:service_shop/core/presentation/appbar/login_appbar.dart';
import 'package:service_shop/core/presentation/buttons/custom_button.dart';
import 'package:service_shop/core/presentation/theme/colors.dart';

class ResignWithnumberScreen extends StatefulWidget {
  const ResignWithnumberScreen({super.key});

  @override
  State<ResignWithnumberScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<ResignWithnumberScreen> {
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
              title: 'Забыли пароль?',
              subtitle:
                  'Введите номер телефона, привязанный \nк вашему аккаунту.\nМы отправим код для восстановления пароля.',
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Form(
                      child: Column(
                        children: [
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Номер телефона',
                              prefixText: '+996',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 8),
                          GestureDetector(
                            onTap: () => context.push(ResignWithemailScreen()),
                            child: Text('Восстановить по e-mail почте'),
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
