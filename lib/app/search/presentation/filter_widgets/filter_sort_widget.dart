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
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
       // vertical: 8.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CategoryButton(onPressed: onPressedCategory),
          SizedBox(width: 16.0),
          SortDropButton(onSelected: onSelectedSortOption),
          //FilterButton(onPressed: onPressedFilter),
        ],
      ),
    );
  }
}
