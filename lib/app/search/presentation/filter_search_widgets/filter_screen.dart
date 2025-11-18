import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:service_shop/app/search/application/filters/filters_controller.dart';
import 'package:service_shop/app/search/application/qwery_params/query_provider.dart';
import 'package:service_shop/app/search/domain/models/filter_model.dart';
import 'package:service_shop/app/search/presentation/filter_search_widgets/category_select_field.dart';
import 'package:service_shop/core/enum/state_type.dart';
import 'package:service_shop/core/presentation/theme/colors.dart';

class FilterScreen extends ConsumerWidget {
  const FilterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(filtersProvider);
    final controller = ref.read(filtersProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ServiceColors.white,
        title: const Text('Фильтр'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: const Text('Сохранить'),
        icon: const Icon(Icons.check),
        backgroundColor: ServiceColors.primaryColor05,
      ),
      body: state.stateType.when(
        initial: () {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            controller.fetchFilters('');
          });
          return const Center(child: CircularProgressIndicator());
        },
        loading: () {
          return const Center(child: CircularProgressIndicator());
        },
        loaded: () {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            physics: BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: _buildFilterFields(state.filters, ref),
            ),
          );
        },
        error: () {
          return Center(child: Text('Ошибка: ${state.error}'));
        },
      ),
    );
  }

  List<Widget> _buildFilterFields(List<FilterModel> filters, WidgetRef ref) {
    List<Widget> widgets = [];
    widgets.add(CategorySelectField());
    widgets.add(const SizedBox(height: 16));
    widgets.add(_PriceFilterWidget());
    for (final filter in filters) {
      if (filter.attributeName.toLowerCase() == 'цвет') {
        widgets.add(_ColorFilterWidget(filter: filter));
      } else {
        widgets.add(_GroupFilterWidget(filter: filter));
      }
      widgets.add(const SizedBox(height: 16));
    }
    return widgets;
  }
}

class _PriceFilterWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Цена', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'от',
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  isDense: true,
                  filled: true,
                  fillColor: ServiceColors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: ServiceColors.primaryColor),
                  ),
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  ref
                      .read(queryProvider.notifier)
                      .setMinPrice(double.tryParse(value) ?? 0);
                },
              ),
            ),
            const SizedBox(width: 22),
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'до',
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  isDense: true,
                  filled: true,
                  fillColor: ServiceColors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: ServiceColors.primaryColor),
                  ),
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  ref
                      .read(queryProvider.notifier)
                      .setMaxPrice(double.tryParse(value) ?? 0);
                },
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
      ],
    );
  }
}

class _GroupFilterWidget extends StatefulWidget {
  final FilterModel filter;

  const _GroupFilterWidget({required this.filter});

  @override
  State<_GroupFilterWidget> createState() => _GroupFilterWidgetState();
}

class _GroupFilterWidgetState extends State<_GroupFilterWidget> {
  List<FilterPropertyModel> selectedProperties = [];

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.filter.attributeName,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 4,
              children: widget.filter.children.map((prop) {
                final isSelected = selectedProperties.contains(prop);
                return OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    backgroundColor: isSelected ? Colors.blue.shade100 : null,

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(6),
                    ),
                    side: BorderSide(
                      color: isSelected
                          ? ServiceColors.primaryColor
                          : Colors.grey,
                      width: 1,
                    ),
                  ),

                  onPressed: () {
                    setState(() {
                      if (isSelected) {
                        selectedProperties.remove(prop);
                        ref.read(queryProvider.notifier).removeFilter(prop);
                      } else {
                        ref.read(queryProvider.notifier).setFilter(prop);
                        selectedProperties.add(prop);
                      }
                    });
                  },
                  child: Text(
                    prop.propertyName,
                    style: TextStyle(
                      color: isSelected ? Colors.blue : null,
                      fontWeight: isSelected
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        );
      },
    );
  }
}

class _ColorFilterWidget extends StatefulWidget {
  final FilterModel filter;

  const _ColorFilterWidget({required this.filter});

  @override
  State<_ColorFilterWidget> createState() => _ColorFilterWidgetState();
}

class _ColorFilterWidgetState extends State<_ColorFilterWidget> {
  List<FilterPropertyModel> selectedColors = [];
  final colorMap = {
    'Черный': Colors.black,
    'Серый': Colors.grey,
    'Коричневый': Colors.brown,
    'Белый': Colors.white,
    'Желтый': Colors.yellow,
    'Красный': Colors.red,
    'Синий': Colors.blue,
    'Оранжевый': Colors.orange,
  };

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.filter.attributeName,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Row(
              children: widget.filter.children.map((prop) {
                final color = colorMap[prop.propertyName] ?? Colors.grey;
                final isSelected = selectedColors.contains(prop);
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        if (isSelected) {
                          ref.read(queryProvider.notifier).removeFilter(prop);
                          selectedColors.remove(prop);
                        } else {
                          ref.read(queryProvider.notifier).setFilter(prop);
                          selectedColors.add(prop);
                        }
                      });
                    },
                    child: CircleAvatar(
                      backgroundColor: color,
                      radius: 16,
                      foregroundColor: isSelected ? Colors.blue : null,
                      child: color == Colors.white
                          ? Container(
                              decoration: BoxDecoration(border: Border.all()),
                            )
                          : null,
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        );
      },
    );
  }
}
