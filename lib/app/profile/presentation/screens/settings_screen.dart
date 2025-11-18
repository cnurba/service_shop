import 'package:flutter/material.dart';
import 'package:service_shop/core/presentation/appbar/custom_appbar.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, "Настройки", showBack: false),
      body: ListView(
        children: [
          ListTile(
            title: Text('Язык'),
            subtitle: Text('Русский'),
            trailing: PopupMenuButton(
              onSelected: (value) {},
              itemBuilder: (BuildContext context) {
                return {'Русский'}.map((String choice) {
                  return PopupMenuItem(value: choice, child: Text(choice));
                }).toList();
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Уведомления',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          ListTile(
            title: Text('Акции'),
            trailing: Switch(value: true, onChanged: (bool value) {}),
          ),
          ListTile(
            title: Text('Доставка'),

            trailing: Switch.adaptive(value: true, onChanged: (bool value) {}),
          ),
          ListTile(
            title: Text('Новости'),
            trailing: Switch(value: false, onChanged: (bool value) {}),
          ),
          ListTile(
            title: Text('Выйти из аккаунта'),
            trailing: Icon(Icons.logout),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
