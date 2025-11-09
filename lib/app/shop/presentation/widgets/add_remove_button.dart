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
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: const Icon(Icons.remove_circle_outline),
            color: ServiceColors.primaryColor,
            iconSize: 30,
            onPressed: onRemove,
          ),
          Text(count.toString(), style: Theme.of(context).textTheme.titleLarge),
          IconButton(
            icon: const Icon(Icons.add_circle_outline),
            color: ServiceColors.primaryColor,
            iconSize: 30,
            onPressed: onAdd,
          ),
        ],
      ),
    );
  }
}
