import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:service_shop/app/basket/application/basket_provider/basket_controller.dart';
import 'package:service_shop/app/core/models/data_tree.dart';
import 'package:service_shop/app/shop/application/product/product_detail_controller.dart';
import 'package:service_shop/app/shop/application/product_detail_loader/product_detail_loader_controller.dart';
import 'package:service_shop/app/shop/application/products/shop_product_controller.dart';
import 'package:service_shop/app/shop/application/shops/shops_provider.dart';
import 'package:service_shop/app/shop/presentation/shop_detail/product_detail_loader_screen.dart';
import 'package:service_shop/app/shop/presentation/shop_detail/product_detail_screen.dart';
import 'package:service_shop/app/shop/presentation/widgets/shop_product_detail_card.dart';
import 'package:service_shop/core/enum/state_type.dart';
import 'package:service_shop/core/extansions/router_extension.dart';
import 'package:service_shop/core/presentation/theme/colors.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});
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
              if (state.status == StateType.loading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state.status == StateType.error) {
                return Center(child: Text('Ошибка: ${state.error}'));
              }
              if (state.categories.isEmpty) {
                return const Center(child: Text('Нет товаров'));
              }
              return ListView.builder(
                itemCount: state.categories.length,
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.all(8.0),
                itemBuilder: (context, index) {
                  final category = state.categories[index];
                  return ListView(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    children: [
                      SizedBox(height: 8),
                      Text(
                        category.category,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      SizedBox(height: 8),
                      GridView.builder(
                        shrinkWrap: true,
                        physics:
                            const NeverScrollableScrollPhysics(), // disables inner scrolling
                        // padding: const EdgeInsets.only(right: 8),
                        itemCount: category.products.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 8,
                              crossAxisSpacing: 2,
                              childAspectRatio:
                                  0.6, // adjust to make card look nice
                            ),
                        itemBuilder: (context, index) {
                          final product = category.products[index];
                          return ProductCard(
                            quantity: ref
                                .watch(basketProvider)
                                .getProductCount(product, product.branchUuid),
                            product: product,
                            onRemove: () {
                              ref
                                  .read(basketProvider.notifier)
                                  .onMinusCount(product, product.branchUuid);
                            },
                            onAdd: () {
                              final shop = ref
                                  .read(shopsProvider)
                                  .shops
                                  .where((e) => e.id == product.branchUuid)
                                  .first;
                              ref
                                  .read(basketProvider.notifier)
                                  .add(product, shop);
                            },
                            onFavorite: () {},
                            onTap: () async {
                              ref
                                  .read(productDetailLoaderProvider.notifier)
                                  .load(product.branchUuid, product.uuid);

                              final result = await showDialog(
                                context: context,
                                builder: (context) =>
                                    const ProductDetailLoaderScreen(),
                              );
                              if (result is DataTree) {
                                ref
                                    .read(productDetailProvider.notifier)
                                    .initialize(
                                      dataTree: result,
                                      product: product,
                                    );

                                context.push(ProductDetailScreen());
                              }
                            },
                          );
                        },
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
