import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:service_shop/core/presentation/appbar/logo_appbar.dart';
import 'package:service_shop/core/presentation/image/app_image_container.dart';
import '../../domain/models/category_model.dart';
import '../../application/categories/category_list_provider.dart';
import '../../application/categories/category_list_state.dart';

class CategoryScreen extends ConsumerWidget {
  const CategoryScreen(this.selectCategory, {super.key});
  final Function(CategoryModel) selectCategory;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(categoriesProvider);
    return SafeArea(
      child: Scaffold(
        appBar: LogoAppbar(),
        body: Column(
          children: [
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Категории',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.close),
                ),
              ],
            ),
            Divider(),
            Expanded(
              child: _buildBody(state, ref, (selectedCategory) {
                selectCategory(selectedCategory);
                Navigator.of(context).pop();
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBody(
    CategoryListState state,
    WidgetRef ref,
    Function(CategoryModel) selectCategory,
  ) {
    switch (state.status) {
      case CategoryListStatus.loading:
        return const Center(child: CircularProgressIndicator());
      case CategoryListStatus.error:
        return Center(child: Text('Ошибка: ${state.error ?? ''}'));
      case CategoryListStatus.loaded:
        return ListView(
          children: state.categories
              .map((cat) => _CategoryTile(category: cat, onTap: selectCategory))
              .toList(),
        );
      default:
        // Инициируем загрузку, если статус initial
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ref.read(categoriesProvider.notifier).loadCategories();
        });
        return const Center(child: CircularProgressIndicator());
    }
  }
}

class _CategoryTile extends StatefulWidget {
  final CategoryModel category;
  final Function(CategoryModel)? onTap;

  const _CategoryTile({required this.category, required this.onTap});

  @override
  State<_CategoryTile> createState() => _CategoryTileState();
}

class _CategoryTileState extends State<_CategoryTile> {
  bool expanded = false;

  CategoryModel? selectedCategory;

  @override
  Widget build(BuildContext context) {
    final cat = widget.category;
    return ExpansionTile(
      title: Row(
        children: [
          AppImageContainer(image: cat.imageUrl, width: 30, height: 30),
          const SizedBox(width: 8),
          Text(cat.name, style: const TextStyle(fontWeight: FontWeight.w500)),
        ],
      ),
      initiallyExpanded: expanded,
      onExpansionChanged: (val) => setState(() => expanded = val),
      children: cat.children
          .map(
            (child) => ListTile(
              selected: selectedCategory == child,
              onTap: () {
                setState(() {
                  selectedCategory = child;
                  if (widget.onTap != null) {
                    widget.onTap!(child);
                  }
                });
              },
              title: Text(child.name),
              subtitle: child.description.isNotEmpty
                  ? Text(
                      child.description,
                      style: const TextStyle(fontSize: 12),
                    )
                  : null,
              leading: AppImageContainer(
                image: cat.imageUrl,
                width: 40,
                height: 40,
              ), //Icon(Icons.chevron_right, color: Colors.grey),
            ),
          )
          .toList(),
    );
  }
}
