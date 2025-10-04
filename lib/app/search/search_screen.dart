import 'package:flutter/material.dart';
import 'package:service_shop/core/presentation/appbar/search_appbar.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SearchAppBar(hintText: "Поиск"),
      body: const Center(child: Text('Search Screen Content')),
    );
  }
}
