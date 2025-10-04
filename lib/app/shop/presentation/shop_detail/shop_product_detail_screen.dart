import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:service_shop/app/shop/application/shop_products/shop_product_controller.dart';
import 'package:service_shop/app/shop/presentation/shop_detail/product_detail_screen.dart';
import 'package:service_shop/app/shop/presentation/widgets/shop_product_detail_card.dart';
import 'package:service_shop/core/presentation/theme/colors.dart';

import '../../application/shop_products/shop_product_state.dart';

class ShopProductDetailScreen extends StatelessWidget {
  const ShopProductDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final state = ref.watch(shopProductProvider);
        return Scaffold(
          appBar: AppBar(title: Text('Shop Product Detail')),
          backgroundColor: ServiceColors.white,
          body: Builder(
            builder: (context) {
              if (state.status == ShopProductStatus.loading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state.status == ShopProductStatus.error) {
                return Center(child: Text('Ошибка: ${state.error}'));
              }
              if (state.categories.isEmpty) {
                return const Center(child: Text('Нет товаров'));
              }
              return ListView.builder(
                itemCount: state.categories.length,
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.all(16.0),
                itemBuilder: (context, index) {
                  final category = state.categories[index];
                  return ListView(
                    shrinkWrap: true,
                    children: [
                      SizedBox(height: 8),
                      Text(
                        category.category,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      SizedBox(height: 8),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.3,
                        child: ListView.builder(
                          itemCount: category.products.length,
                          padding: EdgeInsets.only(right: 8),
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            final product = category.products[index];
                            return ShopProductDetailCard(product: product,onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                                return ProductDetailScreen(product: product);
                              }));
                            },);
                          },
                        ),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}
