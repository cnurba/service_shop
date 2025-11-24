import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:service_shop/app/favs/presentation/empty_favs_widget.dart';
import 'package:service_shop/app/favs/presentation/screens/favorite_product_card.dart';
import 'package:service_shop/app/shop/application/products/shop_product_controller.dart';
import 'package:service_shop/core/presentation/appbar/favs_app_bar.dart';
import 'package:service_shop/app/shop/presentation/widgets/shop_product_detail_card.dart';
import 'package:service_shop/app/basket/application/basket_provider/basket_controller.dart';
import 'package:service_shop/app/shop/application/product_detail_loader/product_detail_loader_controller.dart';
import 'package:service_shop/app/shop/application/product/product_detail_controller.dart';
import 'package:service_shop/app/shop/application/shops/shops_provider.dart';
import 'package:service_shop/app/shop/presentation/shop_detail/product_detail_loader_screen.dart';
import 'package:service_shop/app/shop/presentation/shop_detail/product_detail_screen.dart';
import 'package:service_shop/app/core/models/data_tree.dart';

class FavsScreen extends ConsumerWidget {
  const FavsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favourites = ref.watch(favouriteProductsProvider);

    return SafeArea(
      child: Scaffold(
        appBar: const FavsAppBar(title: 'Избранное'),
        body: favourites.isEmpty
            ? const EmptyFavsWidget()
            : ListView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: favourites.length,
                itemBuilder: (context, index) {
                  final product = favourites[index];
                  return FavoriteProductCard(
                    product: product,
                    onFavorite: () {
                      final shopProductState = ref.read(shopProductProvider);
                      final categoryIndex = shopProductState.categories
                          .indexWhere(
                            (cat) =>
                                cat.products.any((p) => p.uuid == product.uuid),
                          );
                      int productIndex = -1;
                      if (categoryIndex != -1) {
                        productIndex = shopProductState
                            .categories[categoryIndex]
                            .products
                            .indexWhere((p) => p.uuid == product.uuid);
                      }
                      if (categoryIndex != -1 && productIndex != -1) {
                        ref
                            .read(shopProductProvider.notifier)
                            .toggleFavorite(
                              product.uuid,
                              categoryIndex: categoryIndex,
                              productIndex: productIndex,
                              product: product,
                            );
                      }
                    },
                    onTap: () async {
                      final navigator = Navigator.of(context);
                      ref
                          .read(productDetailLoaderProvider.notifier)
                          .load(product.branchUuid, product.uuid);
                      final result = await showDialog(
                        context: context,
                        builder: (context) => const ProductDetailLoaderScreen(),
                      );
                      if (result is DataTree) {
                        ref
                            .read(productDetailProvider.notifier)
                            .initialize(dataTree: result, product: product);
                        await navigator.push(
                          MaterialPageRoute(
                            builder: (_) => ProductDetailScreen(),
                          ),
                        );
                      }
                    },
                  );
                },
              ),
      ),
    );
  }
}
