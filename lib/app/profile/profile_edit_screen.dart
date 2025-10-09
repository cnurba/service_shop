import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:service_shop/app/profile/widgets/profile_text_field.dart';
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

            const ProfileTextField(label: 'Имя', fieldKey: 'firstName'),
            const SizedBox(height: 12),
            const ProfileTextField(label: 'Фамилия', fieldKey: 'lastName'),
            const SizedBox(height: 12),
            const ProfileTextField(
              label: 'Дата рождения',
              fieldKey: 'birthDate',
              suffixIcon: Icon(Icons.date_range),
            ),
            const SizedBox(height: 12),
            const ProfileTextField(
              label: 'Пол',
              fieldKey: 'gender',
              suffixIcon: Icon(Icons.arrow_forward_ios),
            ),
            const SizedBox(height: 12),
            const ProfileTextField(
              label: 'Телефон',
              fieldKey: 'phone',
              suffixIcon: Icon(Icons.phone),
              statusText: "Подтвeржден",
            ),
            const SizedBox(height: 12),
            const ProfileTextField(
              label: 'E-mail',
              fieldKey: 'email',
              suffixIcon: Icon(Icons.email),
              statusText: "Ожидает \nподтвреждения",
            ),
            const SizedBox(height: 12),
            const ProfileTextField(
              label: 'Пароль',
              fieldKey: 'password',
              obscureText: true,
              suffixIcon: Icon(Icons.lock),
              statusText: "Сменить пароль",
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
