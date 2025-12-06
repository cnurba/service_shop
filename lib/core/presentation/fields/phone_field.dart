import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:service_shop/core/utils/mask_formatter.dart';

import '../../../app/profile/presentation/widgets/status_container.dart';
import '../theme/colors.dart';

class PhoneField extends StatefulWidget {
  const PhoneField({
    super.key,
    this.onChanged,
    this.focusNode,
    this.initialValue ='',
  });

  final ValueChanged<String>? onChanged;
  final FocusNode? focusNode;
  final String initialValue;

  @override
  State<PhoneField> createState() => _PhoneFieldState();
}

class _PhoneFieldState extends State<PhoneField> {
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    controller.text = widget.initialValue;
    controller.addListener(() {
      widget.onChanged?.call(controller.text);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: TextFormField(
        controller: controller,
        autofocus: false,
        keyboardType: TextInputType.phone,
        decoration: const InputDecoration(
          fillColor: ServiceColors.white,
          filled: true,
          labelText: 'Телефон',
          labelStyle: TextStyle(color: ServiceColors.black),
          prefixIcon: Icon(Icons.phone, color: ServiceColors.primaryColor),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(6)),
            borderSide: BorderSide.none,
          ),
        ),
        //onChanged: widget.onChanged,
        autovalidateMode: AutovalidateMode.disabled,
        validator: (v) {
          ///email validate
          if (v!.isEmpty) {
            return 'Поле не может быть пустым';
          } else if (v.length < 14) {
            return 'Неправильный формат номера';
          }
          return null;
        },
        inputFormatters: [maskFormatter],
      ),
    );
  }
}
