import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:service_shop/app/profile/presentation/widgets/status_container.dart';

import '../theme/colors.dart';

class PasswordField extends StatefulWidget {
  const PasswordField({super.key, required this.onChanged, this.focusNode, required this.title});

  final ValueChanged<String>? onChanged;
  final FocusNode? focusNode;
  final String title;

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool isObscured = true;
  final formKey = GlobalKey<FormState>();

  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Введите пароль';
    }
    if (value.length < 8) {
      return 'Пароль должен быть не менее 8 символов';
    }
    final hasLetter = RegExp(r'[A-Za-zА-Яа-яЁё]').hasMatch(value);
    final hasDigit = RegExp(r'\d').hasMatch(value);
    if (!hasLetter || !hasDigit) {
      return 'Пароль должен содержать буквы и цифры';
    }
    return null;
  }
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.only(top: 16),
        child: TextFormField(
          autofocus: false,
          focusNode: widget.focusNode,
          obscureText: isObscured,
          validator: passwordValidator,
          decoration: InputDecoration(
            fillColor: ServiceColors.white,
            filled: true,
            labelText: widget.title,
            prefixIcon: Icon(
              Icons.lock_outline,
              color: ServiceColors.primaryColor,
            ),
            labelStyle: const TextStyle(color: ServiceColors.black),
            hintText: "******",
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(6)),
              borderSide: BorderSide.none,
            ),
            suffixIcon: IconButton(
              onPressed: () {
                setState(() => isObscured = !isObscured);
              },
              icon: isObscured
                  ? const Icon(Icons.remove_red_eye_outlined)
                  : const Icon(Icons.remove_red_eye),
            ),
          ),
          onChanged: widget.onChanged,
        ),
      ),
    );
  }
}
