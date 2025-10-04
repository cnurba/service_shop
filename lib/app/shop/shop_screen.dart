import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:service_shop/app/shop/application/shop_products/shop_product_controller.dart';
import 'package:service_shop/app/shop/application/shops/shops_provider.dart';
import 'package:service_shop/app/shop/application/shops/shops_state.dart';
import 'package:service_shop/app/shop/presentation/shop_detail/shop_product_detail_screen.dart';
import 'package:service_shop/core/presentation/appbar/logo_appbar.dart';
import 'presentation/shop_card.dart';

class ShopScreen extends ConsumerWidget {
  const ShopScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(shopsProvider);
    return SafeArea(
      minimum: EdgeInsets.zero,
      child: Scaffold(
        appBar: LogoAppbar(),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 16),
                child: Text(
                  'Магазины',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
              Expanded(
                child: Builder(
                  builder: (context) {
                    if (state.status == ShopsStatus.loading) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (state.status == ShopsStatus.error) {
                      return Center(child: Text('Ошибка: ${state.error}'));
                    }
                    if (state.shops.isEmpty) {
                      return const Center(child: Text('Нет магазинов'));
                    }
                    return GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.7,
                            crossAxisSpacing: 0,
                            mainAxisSpacing: 2,
                          ),
                      itemCount: state.shops.length,
                      itemBuilder: (context, index) {
                        final shop = state.shops[index];
                        return ShopCard(
                          shop: shop,
                          onTap: () {
                            ref
                                .read(shopProductProvider.notifier)
                                .loadShopProducts(shop.id);
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) {
                                  return ShopProductDetailScreen();
                                },
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
