import 'package:flutter/material.dart';
import 'package:service_shop/core/presentation/theme/colors.dart';

class FaqCard extends StatelessWidget {
  final List<String> faqs;

  const FaqCard({super.key, required this.faqs});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: ServiceColors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: faqs.length,
        separatorBuilder: (_, __) => const Divider(height: 1),
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(faqs[index], style: const TextStyle(fontSize: 15)),
            trailing: const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 18,
              color: Colors.grey,
            ),
            onTap: () {
              // Add your tap action here
            },
          );
        },
      ),
    );
  }
}
