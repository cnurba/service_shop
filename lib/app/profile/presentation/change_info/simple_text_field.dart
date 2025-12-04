import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/presentation/theme/colors.dart';

class SimpleTextField extends StatelessWidget {
  const SimpleTextField({
    super.key,
    required this.labelText,
    this.onChanged,
    this.inputFormatters,
    this.errorText,
    this.obscureText = false,
    this.keyboardType = TextInputType.text, this.hintText, this.initialValue,
  });

  final Function(String)? onChanged;
  final String labelText;
  final bool obscureText;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final String? hintText;
  final String? initialValue;
  final String? errorText;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(labelText),
        const SizedBox(height: 8),
        TextFormField(
          style: const TextStyle(fontSize: 24),
          autofocus: true,
          initialValue: initialValue,
          obscureText: obscureText,
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          decoration: InputDecoration(
              fillColor: ServiceColors.white,
            filled: true,
            hintText: hintText,
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(16)),
              borderSide: BorderSide.none,
            ),
            errorText: errorText
          ),
          onChanged: onChanged,
          autovalidateMode: AutovalidateMode.disabled,
        ),
      ],
    );
  }
}
