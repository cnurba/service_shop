import 'package:flutter/material.dart';
import '../theme/colors.dart';

class DateField extends StatefulWidget {
  const DateField({
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
  State<DateField> createState() => _DateFieldState();
}

class _DateFieldState extends State<DateField> {
  DateTime? selectedDate; // ADD THIS

  @override
  Widget build(BuildContext context) {
    final DateTime today = DateTime.now();
    final DateTime hundredYearsAgo = DateTime(today.year - 100, today.month, today.day);
    final currentWidth = MediaQuery.of(context).size.width;

    return currentWidth > 375
        ? Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),

        GestureDetector(
          onTap: () async {
            final DateTime today = DateTime.now();
            final DateTime hundredYearsAgo = DateTime(today.year - 100, today.month, today.day);

            final DateTime? selectedDate = await showDatePicker(
              context: context,
              initialDate: today,
              firstDate: hundredYearsAgo,
              lastDate: today,
            );

            if (selectedDate != null) {
              final formatted =
                  "${selectedDate.year}-${selectedDate.month}-${selectedDate.day}";

              widget.controller?.text = formatted;

              setState(() => this.selectedDate = selectedDate);
            }
          },
          child: TextFormField(
            controller: widget.controller,
            style: const TextStyle(fontSize: 24),
            focusNode: widget.focusNode,
            enabled: false,
            autofocus: false,
            decoration: const InputDecoration(
              fillColor: ServiceColors.white,
              filled: true,
              hintText: 'Дата рождения',
              hintStyle: TextStyle(color: ServiceColors.black, fontSize: 14),
              suffixIcon: Icon(Icons.calendar_today, color: ServiceColors.black),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(6)),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
      ],


// For small phone (iphone 7, 8, se)

    ) : Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Дата рождения',
            // localization.email, //
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: widget.controller,
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
            onChanged: widget.onChanged,
            onEditingComplete: widget.onEditingComplete,
            autovalidateMode: AutovalidateMode.disabled,
            validator: widget.validator,
          )
        ]
    );
  }
}