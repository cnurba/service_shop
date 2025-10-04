import 'package:flutter/material.dart';
import 'package:service_shop/core/presentation/theme/colors.dart';

class FilterButton extends StatelessWidget {
  const FilterButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: ServiceColors.primaryColor,
          borderRadius: BorderRadius.circular(22),
        ),
        child: Row(
          children: [
            Icon(icon, color: ServiceColors.white, size: 16),
            const SizedBox(width: 4),
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: ServiceColors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );

    //   TextButton.icon(
    //   onPressed: onPressed,
    //   style: TextButton.styleFrom(
    //     backgroundColor: ServiceColors.primaryColor,
    //     elevation: 2,
    //     fixedSize: Size(MediaQuery.of(context).size.width * 0.4, 15),
    //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    //   ),
    //   label: Text(
    //     label,
    //     style: Theme.of(context).textTheme.bodySmall!.copyWith(
    //       color: ServiceColors.white,
    //       fontWeight: FontWeight.w600,
    //     ),
    //   ),
    //   icon: Icon(icon, color: ServiceColors.white),
    // );
  }
}
