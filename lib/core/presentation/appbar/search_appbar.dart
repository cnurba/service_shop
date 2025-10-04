import 'package:flutter/material.dart';
import 'package:service_shop/core/presentation/theme/colors.dart';

class SearchAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String hintText;

  final ValueChanged<String>? onChanged;
  final VoidCallback? onSearch;

  const SearchAppBar({
    super.key,
    this.hintText = 'Поиск',
    this.onChanged,
    this.onSearch,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Container(
        height: 40,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: ServiceColors.primaryColor, width: 1),
        ),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                onChanged: onChanged,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  border: InputBorder.none,
                  hintText: hintText,
                  hintStyle: const TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.search, color: ServiceColors.primaryColor),
              onPressed: onSearch,
            ),
          ],
        ),
      ),
      centerTitle: true,
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 10);
}
