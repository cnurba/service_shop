import 'package:flutter/material.dart';
import 'package:service_shop/app/favs/presentation/empty_favs_widget.dart';
import 'package:service_shop/core/presentation/appbar/favs_app_bar.dart';

class FavsScreen extends StatelessWidget {
  const FavsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: FavsAppBar(title: 'Избранное'),
        body: ListView(
          children: const [
            /// Виджет показывает у вас еще нет избранных товаров
            EmptyFavsWidget(),
          ],
        ),
      ),
    );
  }
}
