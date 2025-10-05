import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:service_shop/app/search/application/qwery_params/query_provider.dart';
import 'package:service_shop/app/search/presentation/filter_search_widgets/category_screen.dart';
import 'package:service_shop/core/presentation/theme/colors.dart';

class CategorySelectField extends ConsumerStatefulWidget {
  const CategorySelectField({super.key});

  @override
  ConsumerState<CategorySelectField> createState() =>
      _CategorySelectFieldState();
}

class _CategorySelectFieldState extends ConsumerState<CategorySelectField> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final queryState = ref.watch(queryProvider);
    _controller.text = queryState.category?.name ?? '';
    return TextField(
      controller: _controller,
      readOnly: true,
      decoration: InputDecoration(
        hintText: 'Выберите категорию',
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        isDense: true,
        filled: true,
        fillColor: ServiceColors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: ServiceColors.primaryColor),
        ),
        suffixIcon: Icon(
          Icons.arrow_drop_down,
          color: ServiceColors.primaryColor,
        ),
      ),
      onTap: () {
        _openCategorySelectionBottomSheet(context);
      },
    );
  }

  /// Opens the category selection dialog.
  void _openCategorySelectionBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: (2 / 2.5) * MediaQuery.of(context).size.height,
          ),
          child: CategoryScreen((selectedCategory) {
            ref.read(queryProvider.notifier).setCategory(selectedCategory);
           // Navigator.of(context).pop();
          }),
        );
      },
    );
  }
}
