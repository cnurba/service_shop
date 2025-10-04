
import 'package:flutter/material.dart';
import 'package:service_shop/app/shop/domain/models/shop_products.dart';

class ShopAttributeSelectWidget extends StatefulWidget {
  const ShopAttributeSelectWidget({super.key, required this.attribute, this.onSelected});
  final ShopProductAttribute attribute;
  final Function(String attributeName, String propertyValue)? onSelected;

  @override
  State<ShopAttributeSelectWidget> createState() => _ShopAttributeSelectWidgetState();
}

class _ShopAttributeSelectWidgetState extends State<ShopAttributeSelectWidget> {

  String selectedValue = "";

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 4,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.attribute.attributeName,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Wrap(
            spacing: 8,
            children: widget.attribute.properties.map((prop) {
              // final selected =
              //     selectedAttributes[attr.attributeName] ==
              //     prop.propertyValue;
              return ChoiceChip(
                label: Text(prop.propertyValue),

                selected: selectedValue == prop.propertyValue,
                onSelected: (val) {
                  setState(() {
                    selectedValue =
                        prop.propertyValue;
                  });
                },
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
