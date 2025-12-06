import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../theme/colors.dart';

class AppTextField extends StatefulWidget {
  const AppTextField({
    super.key,
    this.onChanged,
    this.inputFormatters,
    this.initialValue,
    this.labelText,
    this.prefixIcon,
    this.focusNode,
  });

  final Function(String value)? onChanged;
  final String? labelText;
  final List<TextInputFormatter>? inputFormatters;
  final String? initialValue;
  final IconData? prefixIcon;
  final FocusNode? focusNode;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    if (widget.initialValue != null) {
      if (widget.initialValue!.isNotEmpty) {
        controller.text = widget.initialValue!;
      }
    }

    controller.addListener(() {
      if (widget.onChanged != null) {
        widget.onChanged!(controller.text);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: TextFormField(
        controller: controller,
        focusNode: widget.focusNode,
        autofocus: widget.focusNode?.hasFocus ?? false,
        inputFormatters: widget.inputFormatters,
        validator: (value) {
          if(value==null || value.isEmpty){
            return "Не заполнено поле ${widget.labelText}";
          }
          return null;
        },
        decoration: InputDecoration(
          fillColor: ServiceColors.white,
          filled: true,
          labelText: widget.labelText,
          prefixIcon: Icon(
            widget.prefixIcon,
            color: ServiceColors.primaryColor,
          ),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(6)),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
