import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:service_shop/app/search/application/qwery_params/query_provider.dart';
import 'package:service_shop/app/search/presentation/filter_search_widgets/category_screen.dart';
import 'package:service_shop/app/search/presentation/filter_search_widgets/filter_screen.dart';
import 'package:service_shop/app/search/presentation/filter_widgets/filter_sort_widget.dart';
import 'package:service_shop/core/extansions/router_extension.dart';
import 'package:service_shop/core/presentation/appbar/search_appbar.dart';
import 'package:service_shop/core/presentation/theme/colors.dart';

class SearchScreen extends ConsumerWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final queryState = ref.watch(queryProvider);
    return Scaffold(
      appBar: SearchAppBar(hintText: "Поиск",onChanged: (value) {
          ref.read(queryProvider.notifier).setSearchText(value);
      },),
      body: Column(
        children: [
          /// Create a FilterSortWidget with navigation to CategoryScreen and FilterScreen
          Container(
            decoration: BoxDecoration(
              color: ServiceColors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4.0,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: [
                queryState.category != null
                    ? Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 0.0,
                        ),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Chip(
                            label: Text(queryState.category!.name),
                            visualDensity: VisualDensity.compact,
                            backgroundColor: ServiceColors.primaryColor.withOpacity(0.1),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            onDeleted: () {
                              ref.read(queryProvider.notifier).clearCategory();
                            },
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),

                FilterSortWidget(
                  onSelectedSortOption: (sortOption) {
                    ref.read(queryProvider.notifier).setSortBy(sortOption.id);
                  },
                  onPressedCategory: () {
                    context.push(
                      CategoryScreen((selectedCategory) {
                        ref
                            .read(queryProvider.notifier)
                            .setCategory(selectedCategory);
                      }),
                    );
                  },
                  onPressedFilter: () {
                    context.push(FilterScreen());
                  },
                ),
              ],
            ),
          ),

          const Expanded(
            child: Center(
              child: Text(
                'Результаты поиска появятся здесь',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
