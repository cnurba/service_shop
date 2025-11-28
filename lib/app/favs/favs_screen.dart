import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:service_shop/app/basket/application/basket_provider/basket_controller.dart';
import 'package:service_shop/app/favs/application/favorites_product_provider.dart';
import 'package:service_shop/app/favs/presentation/empty_favs_widget.dart';
import 'package:service_shop/app/favs/presentation/screens/favorite_product_card.dart';
import 'package:service_shop/app/shop/application/product/product_detail_controller.dart';
import 'package:service_shop/app/shop/application/shops/shops_provider.dart';
import 'package:service_shop/core/presentation/appbar/favs_app_bar.dart';

class FavsScreen extends ConsumerWidget {
  const FavsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favourites = ref.watch(favoritesProductProvider);

    return SafeArea(
      child: Scaffold(
        appBar: const FavsAppBar(title: 'Избранное'),
        body: favourites.favoriteProducts.isEmpty
            ? const EmptyFavsWidget()
            : ListView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: favourites.favoriteProducts.length,
                itemBuilder: (context, index) {
                  final product = favourites.favoriteProducts.elementAt(index);
                  return FavoriteProductCard(
                    product: product,
                    onFavorite: () {
                      ref
                          .read(favoritesProductProvider.notifier)
                          .unLikes(product);
                    },
                    onTap: () {
                      // ref.read(productDetailProvider.notifier).addCount();
                      final shop = ref
                          .read(shopsProvider)
                          .shops
                          .where((e) => e.id == product.branchUuid)
                          .first;
                      ref.read(basketProvider.notifier).add(product, shop);
                    },
                  );
                },
              ),
      ),
    );
  }
}
