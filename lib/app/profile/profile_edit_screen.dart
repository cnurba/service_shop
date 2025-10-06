import 'package:flutter/material.dart';

class ProfileEditScreen extends StatelessWidget {
  const ProfileEditScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Мои данные")),
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

            // Личные данные
            const TextField(
              decoration: InputDecoration(
                label: Text('Имя'),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            const TextField(
              decoration: InputDecoration(
                label: Text('Фамилия'),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            const TextField(
              decoration: InputDecoration(
                label: Text('Дата рождения'),
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.date_range),
              ),
            ),
            const SizedBox(height: 12),
            const TextField(
              decoration: InputDecoration(
                label: Text('Пол'),
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.arrow_forward_ios),
              ),
            ),
            const SizedBox(height: 12),

            // Телефон
            Row(
              children: [
                const Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      label: Text('Телефон'),
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(Icons.phone),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    "   Подтвeржден",
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Email
            Row(
              children: [
                const Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      label: Text('E-mail'),
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(Icons.email),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    "Ожидает \n подтвреждения",
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Пароль
            Row(
              children: [
                const Expanded(
                  child: TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      label: Text('Пароль'),
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(Icons.lock),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    "Сменить пароль",
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
