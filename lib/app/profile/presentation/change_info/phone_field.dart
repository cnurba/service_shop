import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/presentation/theme/colors.dart';

class PhoneField extends StatelessWidget {
  const PhoneField({
    super.key,
    this.onChanged,
    this.focusNode,
    this.onEditingComplete,
    this.validator,
    this.controller,

  });

  final ValueChanged<String>? onChanged;
  final FocusNode? focusNode;
  final VoidCallback? onEditingComplete;
  final String? Function(String?)? validator;
  final TextEditingController? controller;


  @override
  Widget build(BuildContext context) {
    final currentWidth = MediaQuery.of(context).size.width;
    return currentWidth  > 375 ? Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Телефон',
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
            keyboardType: TextInputType.phone,
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
            keyboardType: TextInputType.phone,
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