// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:service_shop/app/shop/application/products/shop_product_controller.dart';
// import 'package:service_shop/app/shop/presentation/widgets/shop_product_detail_card.dart';

// class FavouriteScreen extends ConsumerWidget {
//   const FavouriteScreen({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final favourites = ref.watch(favouriteProductsProvider);
//     return Scaffold(
//       appBar: AppBar(title: const Text('Избранные товары')),
//       body: favourites.isEmpty
//           ? const Center(child: Text('Нет избранных товаров'))
//           : GridView.builder(
//               padding: const EdgeInsets.all(8),
//               itemCount: favourites.length,
//               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2,
//                 mainAxisSpacing: 8,
//                 crossAxisSpacing: 2,
//                 childAspectRatio: 0.6,
//               ),
//               itemBuilder: (context, index) {
//                 final product = favourites[index];
//                 return ProductCard(
//                   product: product,
//                   quantity: 0,
//                   onRemove: null,
//                   onAdd: null,
//                   onFavorite: null,
//                   onTap: null,
//                 );
//               },
//             ),
//     );
//   }
// }
