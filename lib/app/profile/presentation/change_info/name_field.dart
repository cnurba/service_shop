import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/presentation/theme/colors.dart';

class NameField extends StatelessWidget {
  const NameField({
    super.key,
    this.onChanged,
    this.focusNode,
    this.onEditingComplete,
    this.validator,
    this.controller,
    this.hintText = "Мисалы: Иванов Иван Иванович",
    this.labelText = "Толук аты-жөнүңүз",
  });

  final ValueChanged<String>? onChanged;
  final FocusNode? focusNode;
  final VoidCallback? onEditingComplete;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final String hintText;
  final String labelText;

  @override
  Widget build(BuildContext context) {
    final currentWidth = MediaQuery.of(context).size.width;

    return currentWidth  > 375 ? Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Имя',
            // localization.email, //
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: controller,
            style: const TextStyle(fontSize: 24),
            autofocus: false,
            decoration: const InputDecoration(
              fillColor: ServiceColors.white,
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(6)),
                borderSide: BorderSide.none,
              ),
            ),
            onChanged: onChanged,
            onEditingComplete: onEditingComplete,
            autovalidateMode: AutovalidateMode.disabled,
            validator: validator,
          )
        ]

    ) : Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '',
            // localization.email, //
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