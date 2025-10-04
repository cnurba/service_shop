import 'package:flutter/material.dart';
import 'package:service_shop/app/search/presentation/category_screen.dart';
import 'package:service_shop/app/search/presentation/widgets/filter_button.dart';
import 'package:service_shop/app/search/presentation/widgets/sort_custom_dialog.dart';
import 'package:service_shop/core/extansions/router_extension.dart';
import 'package:service_shop/core/presentation/appbar/search_appbar.dart';
import 'package:service_shop/core/presentation/theme/colors.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SearchAppBar(hintText: "Поиск"),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FilterButton(
                onPressed: () {
                  context.push(CategoryScreen((category) {

                  },));
                },
                icon: Icons.select_all,
                label: "Категории",
              ),
              FilterButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return SortCustomDialog();
                    },
                  );
                },
                icon: Icons.sort,
                label: "Сортировать по",
              ),
              FilterButton(
                onPressed: () {},
                icon: Icons.filter_list_outlined,
                label: "Фильтр",
              ),
            ],
          ),
          // Expanded(
          //   child: Center(
          //     child: Text(
          //       'Здесь будет отображаться результат поиска',
          //       style: TextStyle(
          //         fontSize: 16,
          //         color: ServiceColors.primaryColor,
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
