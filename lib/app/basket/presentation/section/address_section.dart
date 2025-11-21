import 'package:flutter/material.dart';

class AddressSection extends StatelessWidget {
  const AddressSection({super.key,
    required this.onNameChanged,
    required this.onNamePhone,
    required this.onCityChanged,
    required this.onStreetChanged,
    required this.onApartmentChanged,
    required this.onSaveInfoChanged,
  });

  final Function(String name) onNameChanged;
  final Function(String phone) onNamePhone;
  final Function(String city) onCityChanged;
  final Function(String street) onStreetChanged;
  final Function(String apartment) onApartmentChanged;
  final Function(bool saveInfo) onSaveInfoChanged;

  @override
  Widget build(BuildContext context) {
    bool _isChecked = false;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Адрес и контактные данные',
          style: TextTheme.of(context).titleMedium,
        ),
        SizedBox(height: 16),

        Row(
          children: [
            Expanded(
              child: TextField(
                onChanged: (value) => onNameChanged(value),
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Имя',
                ),
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: TextField(
                onChanged: (value) => onNamePhone(value),
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Телефон',
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: TextField(
                onChanged: (value) => onCityChanged(value),
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Город, область',
                ),
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: TextField(
                onChanged: (value) => onStreetChanged(value),
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Улица',
                ),
              ),
            ),
            SizedBox(width: 8),

            Expanded(
              child: TextField(
                onChanged: (value) => onApartmentChanged(value),
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Дом, квартира',
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        Row(
          children: [
            Checkbox(
              value: _isChecked,
              onChanged: (newValue) {
                onSaveInfoChanged(newValue!);
                // setState(() {
                //
                //   });
                  _isChecked = newValue;
              },
            ),
            Text('Сохранить эти данные для будущих заказов'),
          ],
        ),
      ],
    );
  }
}
