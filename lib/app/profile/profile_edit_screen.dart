import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:service_shop/app/profile/presentation/change_info/birth_date_field.dart';
import 'package:service_shop/app/profile/presentation/change_info/email_field.dart';
import 'package:service_shop/app/profile/presentation/change_info/gender_field.dart';
import 'package:service_shop/app/profile/presentation/change_info/name_field.dart';
import 'package:service_shop/app/profile/presentation/change_info/password_field.dart';
import 'package:service_shop/app/profile/presentation/change_info/phone_field.dart';
import 'package:service_shop/app/profile/presentation/change_info/surname_field.dart';
import 'package:service_shop/app/profile/presentation/widgets/profile_text_field.dart';
import 'package:service_shop/core/presentation/appbar/custom_appbar.dart';
import 'package:service_shop/core/presentation/theme/colors.dart';

class ProfileEditScreen extends ConsumerWidget {
  const ProfileEditScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: customAppBar(context, "Мои данные", showBack: false),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CircleAvatar(radius: 40, child: Icon(Icons.person, size: 40)),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {},
              child: const Text("Изменить фото"),
            ),
            const SizedBox(height: 16),

            NameField(
              // controller: ,
              onChanged: (value) {
              },
                ),
            const SizedBox(height: 12),
             SurnameField(),
            const SizedBox(height: 12),
            const BirthdateField(
            ),
            const SizedBox(height: 12),
             GenderField(

            ),
            const SizedBox(height: 12),
             PhoneField(

            ),
            const SizedBox(height: 12),
             EmailField(
              onChanged: (String value) {
              },

            ),
            const SizedBox(height: 12),
            PasswordField(
              onChanged: (String value) {
              }, title: 'Пароль',

            ),
            SizedBox(height: 24),
            Container(
              width: 230,
              height: 35,
              decoration: BoxDecoration(
                color: ServiceColors.primaryColor,
                borderRadius: BorderRadius.circular(12),
              ),
              alignment: Alignment.center,
              child: Text(
                'Сохранить изменения',
                textAlign: TextAlign.center,
                style: TextStyle(color: ServiceColors.cardBgColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
