import 'package:flutter/material.dart';
import 'package:service_shop/core/presentation/theme/colors.dart';

class CategoryButton extends StatelessWidget {
  const CategoryButton({super.key, this.onPressed});

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(
        Icons.category_outlined,
        color: ServiceColors.primaryColor,
      ),
      iconSize: 30,
      onPressed: onPressed,
    );
  }
}
