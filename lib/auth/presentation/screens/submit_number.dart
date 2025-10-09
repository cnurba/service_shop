import 'package:flutter/material.dart';
import 'package:service_shop/auth/presentation/widgets/auth_container.dart';
import 'package:service_shop/auth/presentation/widgets/otp_screen.dart';
import 'package:service_shop/core/presentation/appbar/login_appbar.dart';
import 'package:service_shop/core/presentation/buttons/custom_button.dart';
import 'package:service_shop/core/presentation/theme/colors.dart';

class SubmitNumberScreen extends StatefulWidget {
  const SubmitNumberScreen({super.key});

  @override
  State<SubmitNumberScreen> createState() => _SubmitNumberScreenState();
}

class _SubmitNumberScreenState extends State<SubmitNumberScreen> {
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
              title: 'Подтверждение номера',
              child: Column(
                children: [
                  Text(
                    'Мы отправили код на номер \n +996 554 55 44 44',
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 14),
                  Text('Укажите код'),
                  SizedBox(height: 14),
                  OtpScreen(),
                  SizedBox(height: 14),
                  Text(
                    'Не получили код? \n (Отправить снова через 29 сек)',
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 22),
                  CustomButton(
                    text: 'Подтвердить',
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
