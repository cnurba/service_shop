import 'package:flutter/material.dart';
import 'package:service_shop/core/presentation/theme/colors.dart';

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
        color: ServiceColors.primaryColor,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
