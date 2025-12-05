import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../../app/profile/presentation/widgets/status_container.dart';
import '../theme/colors.dart';

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
    return currentWidth  > 375 ? Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 8),
          Expanded(
            child: TextFormField(
              controller: controller,
              style: const TextStyle(fontSize: 20),
              autofocus: false,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                fillColor: ServiceColors.white,
                filled: true,
                labelText: 'Телефон',
                labelStyle: TextStyle(color: ServiceColors.black),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(6)),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: onChanged,
              onEditingComplete: onEditingComplete,
              autovalidateMode: AutovalidateMode.disabled,
              validator: (v){
                ///email validate
                if(v!.isEmpty){
                  return 'Поле не может быть пустым';
                }else if(v.length < 14){
                  return 'Неправильный формат номера';
                }
                return null;
              },
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(14),
                MaskTextInputFormatter(mask: '+996 ###-##-##'),
              ],

            ),
          ),
          const SizedBox(width: 8),
          StatusContainer(text: 'Подтврежден'),
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