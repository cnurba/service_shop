import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:service_shop/core/presentation/theme/colors.dart';

class SortDropButton extends StatefulWidget {
  const SortDropButton({super.key, required this.onSelected});
  final Function(SortOption) onSelected;
  @override
  State<SortDropButton> createState() => _SortDropButtonState();
}

class _SortDropButtonState extends State<SortDropButton> {
  SortOption? selectedOption;
  @override
  Widget build(BuildContext context) {
    return DropdownButton<SortOption>(
      borderRadius: BorderRadius.circular(8),
      isExpanded: false,
      underline: const SizedBox(),
      isDense: false,
      icon: const Icon(Icons.keyboard_arrow_down, color: ServiceColors.primaryColor),
      hint: const Text("Сортировать по"),
      value: selectedOption,
      items: SortOption.options.map((SortOption value) {
        return DropdownMenuItem<SortOption>(
          value: value,
          child: Row(
            children: [
              Icon(value.icon, color: ServiceColors.primaryColor),
              const SizedBox(width: 8),
              Text(value.label),
            ],
          ),
        );
      }).toList(),
      onChanged: (value) {
        selectedOption = value;
        setState(() {});
        if (value != null) {
          widget.onSelected(value);
        }
      },
    );
  }
}

class SortOption extends Equatable {
  final String id;
  final String label;
  final IconData icon;

  const SortOption({required this.id, required this.label, required this.icon});

  static List<SortOption> get options => [
    const SortOption(
      id: 'all',
      label: 'Без сортировки',
      icon: Icons.sort,
    ),
    const SortOption(
      id: 'price_asc',
      label: 'По возрастанию цены',
      icon: Icons.keyboard_arrow_down,
    ),
    const SortOption(
      id: 'price_desc',
      label: 'По убыванию цены',
      icon: Icons.keyboard_arrow_up,
    ),
    const SortOption(
      id: 'popularity',
      label: 'По популярности',
      icon: Icons.trending_up,
    ),
    const SortOption(id: 'newest', label: 'По новинкам', icon: Icons.fiber_new),
  ];

  @override
  List<Object?> get props => [label, icon, id];
}
