import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:service_shop/auth/application/register/register_provider.dart';
import 'package:service_shop/auth/presentation/screens/register_pages/success_password_screen.dart';
import 'package:service_shop/auth/presentation/widgets/auth_container.dart';
import 'package:service_shop/core/extansions/router_extension.dart';
import 'package:service_shop/core/presentation/appbar/login_appbar.dart';
import 'package:service_shop/core/presentation/buttons/custom_button.dart';
import 'package:service_shop/core/presentation/fields/password_field.dart';
import 'package:service_shop/core/presentation/theme/colors.dart';

class NewPasswordScreen extends ConsumerStatefulWidget {
  const NewPasswordScreen({super.key});

  @override
  ConsumerState<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends ConsumerState<NewPasswordScreen> {
  String _passwordErrorText = '';

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final registerState = ref.watch(registerProvider);
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
                      key: formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          PasswordField(
                            title: "Пароль",
                            onChanged: (value) {
                              ref
                                  .read(registerProvider.notifier)
                                  .setPassword(value);
                            },
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Используйте не менее 8 символов, с буквами и цифрами.',
                            style: TextStyle(
                              color: ServiceColors.primaryColor,
                              fontSize: 10,
                            ),
                          ),
                          PasswordField(
                            title: "Повторите пароль",
                            onChanged: (value) {
                              ref
                                  .read(registerProvider.notifier)
                                  .setRepeatPassword(value);
                            },
                          ),

                          SizedBox(height: 8),
                          _passwordErrorText.isEmpty
                              ? SizedBox.shrink()
                              : Text(
                                  _passwordErrorText,
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 10,
                                  ),
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
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        if (registerState.isCorrectPassword) {
                          ref.read(registerProvider.notifier).register();
                          context.push(SuccessPasswordScreen());
                        } else {
                          setState(() {
                            _passwordErrorText = 'Пароль не совпадают!.';
                          });
                        }
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
