import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:service_shop/app/profile/presentation/widgets/change_photo.dart';
import 'package:service_shop/core/presentation/fields/date_field.dart';
import 'package:service_shop/core/presentation/fields/email_field.dart';
import 'package:service_shop/core/presentation/fields/gender_field.dart';
import 'package:service_shop/core/presentation/fields/password_field.dart';
import 'package:service_shop/core/presentation/fields/phone_field.dart';
import 'package:service_shop/core/presentation/appbar/custom_appbar.dart';
import 'package:service_shop/core/presentation/fields/text_field.dart';
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
           ChangePhoto(),
            const SizedBox(height: 16),
            AppTextField(labelText: 'Имя'),
            const SizedBox(height: 12),
            AppTextField(labelText: 'Фамилия'),
            const SizedBox(height: 12),
            const DateField(),
            const SizedBox(height: 12),
            GenderField(),
            const SizedBox(height: 12),
            PhoneField(),
            const SizedBox(height: 12),
            EmailField(onChanged: (String value) {}),
            const SizedBox(height: 12),
            PasswordField(onChanged: (String value) {}),
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
