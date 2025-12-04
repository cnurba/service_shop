import 'package:flutter/material.dart';

import '../../../../core/presentation/theme/colors.dart';


class GenderField extends StatelessWidget {
  const GenderField({
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
    return currentWidth  > 375 ? Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Пол',
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

// For small phone (iphone 7, 8, se)

    ) : Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'ddd',
            // localization.email, // 'Электронная почта',
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
              // color: MurasColors.textColor,
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