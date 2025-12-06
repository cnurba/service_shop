import 'package:flutter/material.dart';
import 'package:service_shop/core/presentation/theme/colors.dart';

class SuccesPaymentScreen extends StatelessWidget {
  const SuccesPaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.check_circle, color: Colors.green, size: 50),
            Text('Оплата прошла успешно'),
            SizedBox(height: 14),
            RichText(
              text: TextSpan(
                text: 'С карты ',
                style: TextStyle(color: ServiceColors.grey),
                children: <TextSpan>[
                  TextSpan(
                    text: '**** 2687',
                    style: TextStyle(color: Colors.black),
                  ),
                  TextSpan(text: ' списано'),
                ],
              ),
            ),
            Text('5 985 KGS'),
          ],
        ),
      ),
    );
  }
}
