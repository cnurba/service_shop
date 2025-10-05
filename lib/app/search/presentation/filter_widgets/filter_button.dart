import 'package:flutter/material.dart';
import 'package:service_shop/core/presentation/theme/colors.dart';

class FilterButton extends StatelessWidget {
  const FilterButton({super.key, this.onPressed});

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(
        Icons.filter_list_outlined,
        color: ServiceColors.primaryColor,
      ),
      iconSize: 30,
      onPressed: onPressed,
    );
  }
}
