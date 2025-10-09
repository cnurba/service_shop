import 'package:flutter/material.dart';
import 'package:service_shop/core/presentation/theme/colors.dart';

class AuthContainer extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget child;

  const AuthContainer({
    super.key,
    required this.title,
    required this.child,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ServiceColors.scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          const SizedBox(height: 12),
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: ServiceColors.primaryColor,
            ),
          ),
          if (subtitle != null)
            Text(
              subtitle!,
              style: TextStyle(color: ServiceColors.primaryColor, fontSize: 10),
            ),
          const SizedBox(height: 14),
          child,
        ],
      ),
    );
  }
}
