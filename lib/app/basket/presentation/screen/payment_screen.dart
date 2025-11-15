import 'package:flutter/material.dart';
import 'package:service_shop/app/basket/presentation/screen/numeric_keyboard.dart';
import 'package:service_shop/core/presentation/appbar/custom_appbar.dart';
import 'package:service_shop/core/presentation/buttons/custom_button.dart';
import 'package:service_shop/core/presentation/theme/colors.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String cvv = '';
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(); // initialize here
  }

  void _onNumberPressed(String number) {
    if (cvv.length < 3) {
      setState(() {
        cvv += number;
        _controller.text = cvv; // update controller
      });
    }
  }

  void _onBackspace() {
    if (cvv.isNotEmpty) {
      setState(() {
        cvv = cvv.substring(0, cvv.length - 1);
        _controller.text = cvv; // update controller
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose(); // dispose controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, 'Онлайн оплата'),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Сумма заказа', style: TextStyle(color: ServiceColors.grey)),
            const SizedBox(height: 12),
            Text(
              '5 985 KGS',
              style: TextTheme.of(
                context,
              ).titleLarge!.copyWith(color: ServiceColors.primaryColor),
            ),
            const SizedBox(height: 22),
            RichText(
              text: TextSpan(
                text: 'Для подтверждения оплаты введите ',
                style: TextStyle(color: ServiceColors.grey),
                children: <TextSpan>[
                  TextSpan(
                    text: 'CVV код',
                    style: TextStyle(color: ServiceColors.primaryColor),
                  ),
                  TextSpan(text: ' карты'),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              height: 45,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: ServiceColors.primaryColor),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Image.asset('assets/img/elcard.png'),
                  Text('**** 2687'),
                  GestureDetector(
                    child: Row(
                      children: [
                        Text(
                          'Выбрать другую карту',
                          style: TextTheme.of(
                            context,
                          ).labelSmall!.copyWith(color: ServiceColors.grey),
                        ),
                        const Icon(Icons.arrow_forward_ios, size: 10),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            SizedBox(
              width: 165,
              child: TextField(
                readOnly: true,
                controller: _controller,
                decoration: InputDecoration(
                  label: Text(
                    'CVV (3 цифры на обороте)',
                    style: TextTheme.of(
                      context,
                    ).labelSmall!.copyWith(color: ServiceColors.grey),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            Expanded(
              child: NumericKeyboard(
                onNumberPressed: _onNumberPressed,
                onBackspace: _onBackspace,
              ),
            ),
            SizedBox(height: 12),
            CustomButton(text: 'Подтвердить оплату'),
          ],
        ),
      ),
    );
  }
}
