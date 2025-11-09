import 'package:flutter/material.dart';
import 'package:service_shop/app/search/presentation/filter_widgets/category_button.dart';
import 'package:service_shop/app/search/presentation/filter_widgets/filter_button.dart';
import 'package:service_shop/app/search/presentation/filter_widgets/sort_drop_button.dart';

class FilterSortWidget extends StatelessWidget {
  const FilterSortWidget({
    super.key,
    this.onPressedCategory,
    required this.onSelectedSortOption,
    this.onPressedFilter,
  });

  final Function()? onPressedCategory;
  final Function(SortOption) onSelectedSortOption;
  final Function()? onPressedFilter;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CategoryButton(onPressed: onPressedCategory),
        SortDropButton(onSelected: onSelectedSortOption),
        FilterButton(onPressed: onPressedFilter),
      ],
    );
  }
}
