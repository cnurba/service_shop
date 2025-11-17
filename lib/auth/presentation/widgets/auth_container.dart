import 'package:flutter/material.dart';
import 'package:service_shop/core/presentation/theme/colors.dart';

class AuthContainer extends StatelessWidget {
  final String title;
  final String? subtitle;
  final IconData? icon;
  final Widget child;

  const AuthContainer({
    super.key,
    required this.title,
    required this.child,
    this.subtitle,
    this.icon,
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
          Icon(icon, color: Colors.green, size: 50),
          const SizedBox(height: 12),
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: ServiceColors.primaryColor,
            ),
          ),
          SizedBox(height: 8),
          if (subtitle != null)
            Text(
              subtitle!,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleSmall,
            ),
          const SizedBox(height: 14),
          child,
        ],
      ),
    );
  }
}
