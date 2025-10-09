import 'package:flutter/material.dart';
import 'package:service_shop/app/profile/widgets/status_container.dart';

class TextFieldWithStatus extends StatelessWidget {
  final Widget textField;
  final String statusText;
  final double textFieldWidth;

  const TextFieldWithStatus({
    super.key,
    required this.textField,
    required this.statusText,
    this.textFieldWidth = 220, // default width
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(width: textFieldWidth, child: textField),
        const SizedBox(width: 8),
        Flexible(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: StatusContainer(text: statusText),
          ),
        ),
      ],
    );
  }
}
