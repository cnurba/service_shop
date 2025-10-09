import 'package:flutter/material.dart';

Future<String?> selectGender(BuildContext context) {
  return showModalBottomSheet<String>(
    context: context,
    builder: (context) {
      return SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text("Мужской"),
              onTap: () => Navigator.pop(context, "Мужской"),
            ),
            ListTile(
              title: const Text("Женский"),
              onTap: () => Navigator.pop(context, "Женский"),
            ),
          ],
        ),
      );
    },
  );
}
