import 'package:flutter/material.dart';

import '../theme/colors.dart';

/// Форма выбора пола
/// drop.
class GenderField extends StatefulWidget {
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
  State<GenderField> createState() => _GenderFieldState();
}

class _GenderFieldState extends State<GenderField> {
  void showGenderPicker() async {
    final selected = await showModalBottomSheet<String>(
      context: context,
      builder: (context) {
        return SizedBox(
          height: 180,
          child: Column(
            children: [
              ListTile(
                title: const Text("Мужчина"),
                onTap: () => Navigator.pop(context, "Мужчина"),
              ),
              ListTile(
                title: const Text("Женщина",),
                onTap: () => Navigator.pop(context, "Женщина"),
              ),
            ],
          ),
        );
      },
    );

    if (selected != null) {
      widget.controller?.text = selected;
      widget.onChanged?.call(selected);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentWidth = MediaQuery.of(context).size.width;
    return currentWidth > 375
        ? Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        TextFormField(
          controller: widget.controller,
          style: const TextStyle(fontSize: 24),
          autofocus: false,
          focusNode: widget.focusNode,
          readOnly: true, // THIS IS CRUCIAL
          onTap: showGenderPicker,
          decoration: const InputDecoration(
            fillColor: ServiceColors.white,
            filled: true,
            labelText: 'Пол',
            labelStyle: TextStyle(color: ServiceColors.black),
            suffixIcon: Icon(
              Icons.arrow_drop_down,
              color: ServiceColors.black,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(6)),
              borderSide: BorderSide.none,
            ),
          ),
          onChanged: widget.onChanged,
          onEditingComplete: widget.onEditingComplete,
          autovalidateMode: AutovalidateMode.disabled,
          validator: widget.validator,
        ),
      ],
    )
        : Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        TextFormField(
          controller: widget.controller,
          style: const TextStyle(fontSize: 12),
          autofocus: false,
          readOnly: true, // Also make small devices readonly
          onTap: showGenderPicker, // Add onTap here too
          decoration: const InputDecoration(
            fillColor: ServiceColors.white,
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(14)),
              borderSide: BorderSide.none,
            ),
          ),
          onChanged: widget.onChanged,
          onEditingComplete: widget.onEditingComplete,
          autovalidateMode: AutovalidateMode.disabled,
          validator: widget.validator,
        ),
      ],
    );
  }
}