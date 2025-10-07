import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:service_shop/app/profile/application/profile_edit/profile_edit_provider.dart';

class ProfileEditScreen extends ConsumerWidget {
  const ProfileEditScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(profileEditProvider);
    final controller = ref.read(profileEditProvider.notifier);

    Widget buildField(
      String label,
      String fieldKey, {
      bool obscure = false,
      Widget? suffix,
    }) {
      return TextField(
        //enabled: false,

        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
          suffixIcon: suffix,
        ),
        obscureText: obscure,
        onTap: (){
          showDatePicker(context: context, firstDate: DateTime(2025,01,01), lastDate: DateTime.now());
        },
        onChanged: (value) => controller.updateField(fieldKey, value),
        controller: TextEditingController(
          text: {
            'firstName': state.firstName,
            'lastName': state.lastName,
            'birthDate': state.birthDate,
            'gender': state.gender,
            'phone': state.phone,
            'email': state.email,
            'password': state.password,
          }[fieldKey],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Мои данные')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const CircleAvatar(radius: 40, child: Icon(Icons.person, size: 40)),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Изменить фото'),
            ),
            const SizedBox(height: 16),
            buildField('Имя', 'firstName'),
            const SizedBox(height: 12),
            buildField('Фамилия', 'lastName'),
            const SizedBox(height: 12),
            buildField(
              'Дата рождения',
              'birthDate',
              suffix: const Icon(Icons.date_range),
            ),
            const SizedBox(height: 12),
            buildField(
              'Пол',
              'gender',
              suffix: const Icon(Icons.arrow_forward_ios),
            ),
            const SizedBox(height: 12),
            buildField('Телефон', 'phone', suffix: const Icon(Icons.phone)),
            const SizedBox(height: 12),
            buildField('E-mail', 'email', suffix: const Icon(Icons.email)),
            const SizedBox(height: 12),
            buildField(
              'Пароль',
              'password',
              obscure: true,
              suffix: const Icon(Icons.lock),
            ),
          ],
        ),
      ),
    );
  }
}
