import 'package:flutter/material.dart';
import 'package:service_shop/core/presentation/appbar/custom_appbar.dart';
import 'package:service_shop/core/presentation/theme/colors.dart';

class AboutAppScreen extends StatelessWidget {
  const AboutAppScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, "О приложении", showBack: false),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 16),
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: ServiceColors.primaryColor,
              ),
              child: Image.asset('assets/logo/logo_s.png'),
            ),
            SizedBox(height: 16),
            Text('Версия 1.2 от 05.10.2025 '),
            SizedBox(height: 16),
            ListTile(
              title: Text('Лицензионное соглашение'),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
            Divider(),
            ListTile(
              title: Text('Политика конфиденциальности'),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
            Divider(),
          ],
        ),
      ),
    );
  }
}
