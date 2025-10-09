import 'package:flutter/material.dart';

class StatusContainer extends StatelessWidget {
  const StatusContainer({
    super.key,
    required this.text,
    this.color,
    this.padding,
  });

  final String text;
  final Color? color;
  final EdgeInsetsGeometry? padding;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color ?? Colors.grey.shade200,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(fontWeight: FontWeight.w500),
      ),
    );
  }
}
