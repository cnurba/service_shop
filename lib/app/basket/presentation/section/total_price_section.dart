import 'package:flutter/material.dart';
import 'package:service_shop/core/presentation/theme/colors.dart';

class TotalPriceSection extends StatelessWidget {
  const TotalPriceSection({super.key, required this.totalShops, required this.totalCount, required this.totalAmount, required this.discount, required this.deliveryCost, required this.finalAmount});
  final int totalShops;
  final double totalCount;
  final double totalAmount;
  final double discount;
  final double deliveryCost;
  final double finalAmount;

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
            Text('$totalShops', style: TextStyle(color: ServiceColors.grey)),
          ],
        ),
        Row(
          children: [
            Text('Товары', style: TextStyle(color: ServiceColors.grey)),
            SizedBox(width: 18),

            Text('${totalCount.truncateToDouble()==totalCount ? totalCount.toInt() : totalCount.toStringAsFixed(0)} шт', style: TextStyle(color: ServiceColors.grey)),
            Spacer(),
            Text('${totalAmount.truncateToDouble() == totalAmount ? totalAmount.toInt() : totalAmount.toStringAsFixed(0)} с', style: TextStyle(color: ServiceColors.grey)),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Скидка', style: TextStyle(color: ServiceColors.grey)),
            Text('${discount.truncateToDouble()==discount ? discount.toInt() : discount.toStringAsFixed(0)} с', style: TextStyle(color: ServiceColors.grey)),
          ],
        ),
        SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Итого', style: TextTheme.of(context).titleMedium),
            Text('${finalAmount.truncateToDouble() == finalAmount ? finalAmount.toInt() : finalAmount.toStringAsFixed(0)} с', style: TextTheme.of(context).titleMedium),
          ],
        ),
        Divider(),
      ],
    );
  }
}
