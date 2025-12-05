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
    return currentWidth  > 375 ? Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 8),
          Expanded(
            child: TextFormField(
              controller: controller,
              style: const TextStyle(fontSize: 24),
              autofocus: false,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                fillColor: ServiceColors.white,
                filled: true,
                labelText: 'E-mail',
                labelStyle: TextStyle(color: ServiceColors.black),
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
                  return 'Please enter your email';
                } else if (!RegExp(
                  r"^[^@\s]+@[^@\s]+\.[^@\s]+$",
                ).hasMatch(value)) {
                  return 'Enter a valid email';
                }
                return null;
              },
            ),
          ),
          const SizedBox(width: 8),
          StatusContainer(text: 'Сменить почту'),
        ]

      ) : Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'ddd',
            // localization.email, // 'Электронная почта',
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: controller,
            style: const TextStyle(fontSize: 12),
            autofocus: false,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              fillColor: ServiceColors.white,
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(14)),
                borderSide: BorderSide.none,
              ),
            ),
            onChanged: onChanged,
            onEditingComplete: onEditingComplete,
            autovalidateMode: AutovalidateMode.disabled,
            validator: validator,
          )
        ]
      );
  }
}