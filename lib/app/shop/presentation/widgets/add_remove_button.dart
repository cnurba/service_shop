import 'package:flutter/material.dart';
import 'package:service_shop/core/presentation/theme/colors.dart';

class AddRemoveButton extends StatelessWidget {
  const AddRemoveButton({
    super.key,
    required this.onAdd,
    required this.onRemove,
    required this.count,
  });

  final VoidCallback onAdd;
  final VoidCallback onRemove;
  final double count;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: ServiceColors.primaryColor),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 2),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: onRemove,
            child: const Icon(
              Icons.remove_circle_outline,
              size: 30,
              color: ServiceColors.primaryColor,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            count.toStringAsFixed(0),
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(width: 8),
          InkWell(
            onTap: onAdd,
            child: const Icon(
              Icons.add_circle_outline,
              size: 30,
              color: ServiceColors.primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
