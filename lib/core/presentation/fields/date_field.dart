import 'package:flutter/material.dart';
import 'package:service_shop/core/extansions/date_time_extension.dart';
import '../theme/colors.dart';

class DateField extends StatefulWidget {
  const DateField({
    super.key,
    required this.onChanged,
    this.focusNode,
    this.initialDate,
    required this.title,
  });

  final ValueChanged<DateTime> onChanged;
  final FocusNode? focusNode;
  final DateTime? initialDate;
  final String title;

  @override
  State<DateField> createState() => _DateFieldState();
}

class _DateFieldState extends State<DateField> {
  DateTime? selectedDate;

  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    if (widget.initialDate != null) {
      controller.text = widget.initialDate!.toFormattedString();
    }
    controller.addListener(() {
      if (selectedDate != null) {
        widget.onChanged(selectedDate!);
      }
    });
    super.initState();
  }

  Future<void> onSelectDateTime() async {
    final DateTime today = DateTime.now();
    final DateTime hundredYearsAgo = DateTime(
      today.year - 70,
      today.month,
      today.day,
    );

    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: today,
      firstDate: hundredYearsAgo,
      lastDate: today,
    );

    if (selectedDate != null) {
      controller.text = selectedDate.toFormattedString();
      setState(() => this.selectedDate = selectedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: GestureDetector(
        onTap: () {
          onSelectDateTime();
        },
        child: TextFormField(
          controller: controller,

          focusNode: widget.focusNode,
          enabled: false,
          autofocus: false,
          decoration: InputDecoration(
            fillColor: ServiceColors.white,
            filled: true,
            labelText: widget.title,
            labelStyle: const TextStyle(color: ServiceColors.black, fontSize: 14),
            suffixIcon: const Icon(
              Icons.calendar_today,
              color: ServiceColors.black,
            ),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(6)),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ),
    );
  }
}
