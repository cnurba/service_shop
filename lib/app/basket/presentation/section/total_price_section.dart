import 'package:flutter/material.dart';
import 'package:service_shop/core/presentation/theme/colors.dart';

class TotalPriceSection extends StatelessWidget {
  const TotalPriceSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Магазины', style: TextStyle(color: ServiceColors.grey)),
            SizedBox(width: 18),
            Text('2', style: TextStyle(color: ServiceColors.grey)),
          ],
        ),
        Row(
          children: [
            Text('Товары', style: TextStyle(color: ServiceColors.grey)),
            SizedBox(width: 18),

            Text('3шт', style: TextStyle(color: ServiceColors.grey)),
            Spacer(),
            Text('3 865 с', style: TextStyle(color: ServiceColors.grey)),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Скидка', style: TextStyle(color: ServiceColors.grey)),
            Text('470 с', style: TextStyle(color: ServiceColors.grey)),
          ],
        ),
        SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Итого', style: TextTheme.of(context).titleMedium),
            Text('5 985 с', style: TextTheme.of(context).titleMedium),
          ],
        ),
        Divider(),
      ],
    );
  }
}
