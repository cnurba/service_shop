import 'package:flutter/material.dart';

import '../../../app/profile/presentation/widgets/status_container.dart';
import '../theme/colors.dart';

class EmailField extends StatelessWidget {
  const EmailField({
    super.key,
    this.onChanged,
    this.focusNode,
    this.onEditingComplete,
    this.validator,
    this.controller,
  });

  final ValueChanged<String>? onChanged;
  final FocusNode? focusNode;
  final Function()? onEditingComplete;
  final String? Function(String?)? validator;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    final currentWidth = MediaQuery.of(context).size.width;
    // final localization = AppLocalizations.of(context);
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: TextFormField(
        controller: controller,
        autofocus: false,
        keyboardType: TextInputType.emailAddress,
        decoration: const InputDecoration(
          fillColor: ServiceColors.white,
          filled: true,
          labelText: 'E-mail',
          labelStyle: TextStyle(color: ServiceColors.black),
          prefixIcon: Icon(
            Icons.email_outlined,
            color: ServiceColors.primaryColor,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(6)),
            borderSide: BorderSide.none,
          ),
        ),
        onChanged: onChanged,
        onEditingComplete: onEditingComplete,
        autovalidateMode: AutovalidateMode.disabled,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Пожалуйста заполните email';
          } else if (!RegExp(r"^[^@\s]+@[^@\s]+\.[^@\s]+$").hasMatch(value)) {
            return 'Неверный формат email';
          }
          return null;
        },
      ),
    );
  }
}
