import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:service_shop/app/shop/application/product_detail_loader/product_detail_loader_controller.dart';
import 'package:service_shop/core/enum/state_type.dart';
import 'package:service_shop/core/extansions/router_extension.dart';

class ProductDetailLoaderScreen extends StatelessWidget {
  const ProductDetailLoaderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,

      child: Consumer(
        builder: (context, ref, child) {
          final result = ref.watch(productDetailLoaderProvider);
          return Dialog(
            child: SizedBox(
              height: 100,
              width: 100,
              child: result.status.when(
                initial: () => SizedBox.shrink(),
                loading: () => const Center(child: CircularProgressIndicator()),
                loaded: () {
                  context.pop(result.dataTree); // Close the dialog when loaded
                  return Center(
                    child: Icon(Icons.check, color: Colors.green, size: 48),
                  );
                },
                error: () => Center(child: Text('Error: ${result.error}')),
              ),
              //Center(child: CircularProgressIndicator()),
            ),
          );
        },
      ),
    );
  }
}
