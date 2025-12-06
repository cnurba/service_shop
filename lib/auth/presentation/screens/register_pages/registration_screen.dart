import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:service_shop/auth/application/register/register_provider.dart';
import 'package:service_shop/auth/application/send_sms/send_sms_controller.dart';
import 'package:service_shop/auth/presentation/screens/register_pages/submit_number_screen.dart';
import 'package:service_shop/auth/presentation/widgets/auth_container.dart';
import 'package:service_shop/core/enum/state_type.dart';
import 'package:service_shop/core/extansions/router_extension.dart';
import 'package:service_shop/core/presentation/appbar/login_appbar.dart';
import 'package:service_shop/core/presentation/buttons/custom_button.dart';
import 'package:service_shop/core/presentation/fields/date_field.dart';
import 'package:service_shop/core/presentation/fields/email_field.dart';
import 'package:service_shop/core/presentation/fields/gender_field.dart';
import 'package:service_shop/core/presentation/fields/phone_field.dart';
import 'package:service_shop/core/presentation/fields/text_field.dart';
import 'package:service_shop/core/presentation/theme/colors.dart';

class RegistrationScreen extends ConsumerStatefulWidget {
  const RegistrationScreen({super.key});

  @override
  ConsumerState<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends ConsumerState<RegistrationScreen> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ServiceColors.primaryColor,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const LoginAppbar(),
            const SizedBox(height: 24),
            AuthContainer(
              title: 'Регистрация',
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Form(
                  key: formKey,

                  child: Column(
                    children: [
                      AppTextField(
                        labelText: 'Фамилия',
                        prefixIcon: Icons.person_outline_rounded,
                        onChanged: (value) {
                          ref
                              .read(registerProvider.notifier)
                              .setLastName(value);
                        },
                      ),
                      AppTextField(
                        labelText: 'Имя',

                        prefixIcon: Icons.person_outline_rounded,
                        onChanged: (value) {
                          ref
                              .read(registerProvider.notifier)
                              .setFirstName(value);
                        },
                      ),
                      DateField(
                        title: "Дата рожения",
                        //initialDate: userProfile.birthDate,
                        onChanged: (value) {
                          ref
                              .read(registerProvider.notifier)
                              .setBirthDate(value);
                        },
                      ),
                      GenderField(
                        initialText: "",
                        onChanged: (value) {
                          ref.read(registerProvider.notifier).setGender(value);
                        },
                      ),
                      PhoneField(
                        onChanged: (value) {
                          ref.read(registerProvider.notifier).setPhone(value);
                        },
                      ),
                      EmailField(
                        onChanged: (String value) {
                          ref.read(registerProvider.notifier).setEmail(value);
                        },
                      ),
                      const SizedBox(height: 22),
                      CustomButton(
                        text: 'Получить код',
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            final phone = ref
                                .read(registerProvider)
                                .userProfile
                                .phone;

                            ref.read(sendSmsProvider.notifier).sendSms(phone);
                            final result = ref.read(sendSmsProvider).stateType;

                            if (result == StateType.error) {
                              final errorText = ref
                                  .read(sendSmsProvider)
                                  .errorText;
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(errorText ?? 'Ошибка')),
                              );
                              return;
                            }
                            context.push(
                              SubmitNumberScreen(phoneNumber: phone),
                            );
                          }
                        },
                      ),
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
