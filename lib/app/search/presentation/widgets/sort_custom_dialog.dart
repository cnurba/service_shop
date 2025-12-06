import 'package:flutter/material.dart';
import 'package:service_shop/core/presentation/theme/colors.dart';

class SortCustomDialog extends StatefulWidget {
  final int selectedIndex;

  const SortCustomDialog({super.key, this.selectedIndex = 0});

  @override
  State<SortCustomDialog> createState() => _SortCustomDialogState();
}

class _SortCustomDialogState extends State<SortCustomDialog> {
  int selectedIndex = 0;

  @override
  void initState() {
    selectedIndex = widget.selectedIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final options = [
      _SortOption(
        icon: Icons.keyboard_arrow_down,
        label: 'По возрастанию цены',
        selected: selectedIndex == 0,
        onTap: () {
          setState(() {
            selectedIndex = 0;
          });
          Navigator.of(context).pop(0);
        },
      ),
      _SortOption(
        icon: Icons.keyboard_arrow_up,
        label: 'По убыванию цены',
        selected: selectedIndex == 1,
        onTap: () {
          setState(() {
            selectedIndex = 1;
          });
          Navigator.of(context).pop(1);
        },
      ),
      _SortOption(
        icon: Icons.trending_up,
        label: 'По популярности',
        selected: selectedIndex == 2,
        onTap: () {
          setState(() {
            selectedIndex = 2;
          });
          Navigator.of(context).pop(2);
        },
      ),
      _SortOption(
        icon: Icons.fiber_new,
        label: 'По новинкам',
        selected: selectedIndex == 3,
        onTap: () {
          setState(() {
            selectedIndex = 3;
          });
          Navigator.of(context).pop(3);
        },
      ),
      _SortOption(
        icon: Icons.location_on_outlined,
        label: 'Ближайшие магазины',
        subtitle:
            'Включите геоданные, чтобы мы показали\nближайшие точки продаж',
        selected: selectedIndex == 4,
        onTap: () {
          setState(() {
            selectedIndex = 4;
          });
          Navigator.of(context).pop(4);
        },
      ),
    ];
    return Dialog(
      alignment: Alignment.topCenter,
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 120),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: options.map((opt) => opt).toList(),
        ),
      ),
    );
  }
}

class _SortOption extends StatelessWidget {
  final IconData icon;
  final String label;
  final String? subtitle;
  final bool selected;
  final VoidCallback? onTap;

  const _SortOption({
    required this.icon,
    required this.label,
    this.subtitle,
    this.selected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: selected ? Colors.blue.withOpacity(0.1) : null,
      child: ListTile(
        leading: Icon(icon, color: ServiceColors.primaryColor),
        title: Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        subtitle: subtitle != null
            ? Text(
                subtitle!,
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              )
            : null,
        onTap: onTap
      ),
    );
  }
}
