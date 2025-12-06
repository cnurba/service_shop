import 'package:flutter/material.dart';

import '../theme/colors.dart';

/// Форма выбора пола
/// drop.
class GenderField extends StatefulWidget {
  const GenderField({
    super.key,
    this.onChanged,
    this.focusNode,
    required this.initialText,
  });

  final ValueChanged<String>? onChanged;
  final FocusNode? focusNode;
  final String initialText;

  @override
  State<GenderField> createState() => _GenderFieldState();
}

class _GenderFieldState extends State<GenderField> {
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    if (widget.initialText.isNotEmpty) {
      controller.text = widget.initialText;
    }

    controller.addListener(() {
      if (controller.text.isNotEmpty) {
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
        autofocus: false,
        focusNode: widget.focusNode,
        readOnly: true,
        onTap: showGenderPicker,
        validator: (value) {
          if (value == null || value.isEmpty  ) {
            return 'Поле не может быть пустым';
          }
          return null;
        },
        decoration: const InputDecoration(
          fillColor: ServiceColors.white,
          prefixIcon: Icon(Icons.person_2_outlined, color: ServiceColors.primaryColor),
          filled: true,
          labelText: 'Пол',
          labelStyle: TextStyle(color: ServiceColors.black),
          suffixIcon: Icon(Icons.arrow_drop_down, color: ServiceColors.black),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(6)),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  void showGenderPicker() async {
    final selectedSex = await showModalBottomSheet<String>(
      context: context,
      builder: (context) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.2,
          child: Column(
            children: [
              SizedBox(height: 16),
              ListTile(
                title: const Text("Мужчина"),
                onTap: () => Navigator.pop(context, "Мужчина"),
              ),
              ListTile(
                title: const Text("Женщина"),
                onTap: () => Navigator.pop(context, "Женщина"),
              ),
            ],
          ),
        );
      },
    );

    if (selectedSex != null) {
      controller.text = selectedSex;
      setState(() {});
    }
  }
}
