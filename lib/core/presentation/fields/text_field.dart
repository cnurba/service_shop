import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../theme/colors.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    this.onChanged,
    this.inputFormatters,
    this.errorText,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.initialValue,
    this.labelText,
  });

  final Function(String)? onChanged;
  final String? labelText;
  final bool obscureText;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final String? initialValue;
  final String? errorText;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        TextFormField(
          style: const TextStyle(fontSize: 20),
          autofocus: true,
          initialValue: initialValue,
          obscureText: obscureText,
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          decoration: InputDecoration(
            fillColor: ServiceColors.white,
            filled: true,
            labelText: labelText,
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(6)),
              borderSide: BorderSide.none,
            ),
            errorText: errorText,
          ),
          onChanged: onChanged,
          autovalidateMode: AutovalidateMode.disabled,
        ),
      ],
    );
  }
}
