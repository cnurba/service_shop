
import 'package:flutter/material.dart';
import 'package:service_shop/app/basket/presentation/empty_basket_widget.dart';
import 'package:service_shop/core/presentation/appbar/favs_app_bar.dart';

class BasketScreen extends StatelessWidget {
  const BasketScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: FavsAppBar(
          title: "Корзина",
        ),
        body: ListView(

          children: const [
            /// Виджет показывает у вас еще нет избранных товаров
            EmptyBasketWidget(),
          ],
        ),
      ),
    );
  }
}
