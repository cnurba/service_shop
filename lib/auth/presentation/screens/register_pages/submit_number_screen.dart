import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:service_shop/auth/application/check_code/check_code_controller.dart';
import 'package:service_shop/auth/application/register/register_provider.dart';
import 'package:service_shop/auth/presentation/screens/register_pages/new_password_screen.dart';
import 'package:service_shop/auth/presentation/widgets/auth_container.dart';
import 'package:service_shop/auth/presentation/widgets/otp_screen.dart';
import 'package:service_shop/core/enum/state_type.dart';
import 'package:service_shop/core/extansions/router_extension.dart';
import 'package:service_shop/core/presentation/appbar/login_appbar.dart';
import 'package:service_shop/core/presentation/buttons/custom_button.dart';
import 'package:service_shop/core/presentation/theme/colors.dart';

class SubmitNumberScreen extends ConsumerStatefulWidget {
  const SubmitNumberScreen({super.key, required this.phoneNumber});

  final String phoneNumber;

  @override
  ConsumerState<SubmitNumberScreen> createState() => _SubmitNumberScreenState();
}

class _SubmitNumberScreenState extends ConsumerState<SubmitNumberScreen> {
  String enteredCode = '';

  int _secondsRemaining = 29;

  String buttonText = 'Подтвердить';
  String errorText = '';

  String get getText {
    if (errorText.isEmpty) {
      return 'Не получили код?';
    }
    return "Вы вели не правильный код";
  }

  @override
  void initState() {
    timeoutCountdown();
    super.initState();
  }

  void timeoutCountdown() {
    Future.delayed(const Duration(seconds: 1), () {
      if (_secondsRemaining > 0) {
        setState(() {
          _secondsRemaining--;
        });
        timeoutCountdown();
      } else {
        setState(() {
          buttonText = 'Отправить снова';
        });
      }
    });
  }

  Future<void> checkCodeResult() async {
    final checkCodeState = ref.watch(checkCodeProvider);
    if (checkCodeState.stateType == StateType.loaded) {
      Future.microtask(() {
        context.push(NewPasswordScreen());
        ref.read(checkCodeProvider.notifier).resetState();
      });


    } else if (checkCodeState.stateType == StateType.error) {
      setState(() {
        errorText = checkCodeState.errorText ?? 'Ошибка при проверке кода.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    checkCodeResult();
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
                    'Мы отправили код на номер \n ${widget.phoneNumber}',
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 14),
                  Text('Укажите код'),
                  SizedBox(height: 14),
                  OtpScreen(
                    onCodeEntered: (code) {
                      print('Entered code: $code');
                      setState(() {
                        enteredCode = code;
                      });
                    },
                  ),
                  SizedBox(height: 14),
                  Text(
                    '$getText \n (Отправить снова через $_secondsRemaining сек)',
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 22),
                  CustomButton(
                    text: buttonText,
                    onPressed: () {
                      if (enteredCode.isNotEmpty) {
                        // Proceed with code verification
                        ref
                            .read(checkCodeProvider.notifier)
                            .verifySms(enteredCode, widget.phoneNumber);
                        checkCodeResult();
                        /// check result and go next screen.
                      } else {
                        // Show error or prompt user to enter code
                        print('Please enter the code before confirming.');
                      }
                    },
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
