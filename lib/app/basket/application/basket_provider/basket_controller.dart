import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:service_shop/app/basket/application/basket_provider/basket_state.dart';
import 'package:service_shop/app/core/models/products/product.dart';
import 'package:service_shop/app/shop/domain/models/shop.dart';

final basketProvider = StateNotifierProvider<BasketController, BasketState>((
  ref,
) {
  return BasketController();
});

class BasketController extends StateNotifier<BasketState> {
  BasketController() : super(BasketState.initial());

  void setDeliveryType(String shopId, String deliveryType, double cost) {
    final existingShopIndex = state.shopItems.indexWhere(
      (item) => item.shop.id == shopId,
    );

    if (existingShopIndex != -1) {
      final existingShopItem = state.shopItems[existingShopIndex];

      final updatedShopItem = BasketShopItem(
        shop: existingShopItem.shop,
        products: existingShopItem.products,
        totalAmount: existingShopItem.totalAmount,
        deliveryType: deliveryType,
        deliveryCost: cost,
      );

      List<BasketShopItem> updatedShopItems = List<BasketShopItem>.from(
        state.shopItems,
      );
      updatedShopItems[existingShopIndex] = updatedShopItem;

      state = BasketState(shopItems: updatedShopItems);
    }
  }

  void add(Product product, Shop shop) {
    // Проверяем, есть ли уже магазин в корзине
    final existingShopIndex = state.shopItems.indexWhere(
      (item) => item.shop.id == shop.id,
    );

    if (existingShopIndex != -1) {
      // Магазин уже есть, добавляем товар в существующий магазин
      final existingShopItem = state.shopItems[existingShopIndex];

      /// Проверяем есть ли уже такой товар в корзине этого магазина
      /// Если есть , тогда просто установливаем количество последнего товара
      /// иначе добавляем новый товар в список

      final productIndex = existingShopItem.products.indexWhere(
        (p) => p.propertyUuid == product.propertyUuid,
      );
      List<BasketShopItem> updatedShopItems = List<BasketShopItem>.from(
        state.shopItems,
      );

      if (productIndex != -1) {
        // Товар уже есть, обновляем его количество
        final existingProduct = existingShopItem.products[productIndex];
        final updatedProduct = existingProduct.copyWith(
          quantity: existingProduct.quantity + 1,
        );

        final updatedProducts = List<Product>.from(existingShopItem.products);
        updatedProducts[productIndex] = updatedProduct;

        final updatedTotalAmount =
            existingShopItem.totalAmount +
            existingProduct.price +
            updatedProduct.quantity;

        final updatedShopItem = BasketShopItem(
          shop: existingShopItem.shop,
          totalAmount: updatedTotalAmount,
          products: updatedProducts,
          deliveryType: existingShopItem.deliveryType,
          deliveryCost: existingShopItem.deliveryCost,
        );

        updatedShopItems[existingShopIndex] = updatedShopItem;
      } else {
        // Товара нет, добавляем его в список
        final updatedProducts = List<Product>.from(existingShopItem.products)
          ..add(product.copyWith(quantity: product.quantity + 1));
        final updatedTotalAmount =
            existingShopItem.totalAmount + product.price * product.quantity;
        final updatedShopItem = BasketShopItem(
          shop: existingShopItem.shop,
          totalAmount: updatedTotalAmount,
          products: updatedProducts,
          deliveryType: existingShopItem.deliveryType,
          deliveryCost: existingShopItem.deliveryCost,
        );
        updatedShopItems[existingShopIndex] = updatedShopItem;
      }

      state = BasketState(shopItems: updatedShopItems);
    } else {
      // Магазин отсутствует, создаем новый элемент магазина в корзине
      final newShopItem = BasketShopItem(
        shop: shop,
        products: [product.copyWith(quantity: 1)],
        totalAmount: product.price,
        deliveryType: '',
        deliveryCost: 0,
      );

      state = BasketState(shopItems: [...state.shopItems, newShopItem]);
    }
  }

  void remove(Product product, String shopId) {
    /// Проверяем, есть ли магазин в корзине
    /// Если есть, то ищем товар в списке товаров магазина
    /// Если товар найден, то удаляем его из списка товаров магазина

    final existingShopIndex = state.shopItems.indexWhere(
      (item) => item.shop.id == shopId,
    );
    if (existingShopIndex != -1) {
      final existingShopItem = state.shopItems[existingShopIndex];
      final productIndex = existingShopItem.products.indexWhere(
        (p) => p.propertyUuid == product.propertyUuid,
      );

      if (productIndex != -1) {
        final updatedProducts = List<Product>.from(existingShopItem.products)
          ..removeAt(productIndex);
        final updatedTotalAmount = existingShopItem.totalAmount - product.price;

        List<BasketShopItem> updatedShopItems = List<BasketShopItem>.from(
          state.shopItems,
        );

        if (updatedProducts.isEmpty) {
          // Если после удаления товаров магазин пуст, удаляем магазин из корзины
          updatedShopItems.removeAt(existingShopIndex);
        } else {
          final updatedShopItem = BasketShopItem(
            shop: existingShopItem.shop,
            products: updatedProducts,
            totalAmount: updatedTotalAmount,
            deliveryType: existingShopItem.deliveryType,
            deliveryCost: existingShopItem.deliveryCost,
          );

          updatedShopItems[existingShopIndex] = updatedShopItem;
        }

        state = BasketState(shopItems: updatedShopItems);
      }
    }
  }

  void onLike(Product product, String shopId) {}

  void onAddCount(Product product, String shopId) {
    /// Поиск товара и магазина в корзине
    /// Увеличивает количество товара в корзине на 1
    final existingShopIndex = state.shopItems.indexWhere(
      (item) => item.shop.id == shopId,
    );
    if (existingShopIndex != -1) {
      final existingShopItem = state.shopItems[existingShopIndex];
      final productIndex = existingShopItem.products.indexWhere(
        (p) => p.propertyUuid == product.propertyUuid,
      );

      if (productIndex != -1) {
        final existingProduct = existingShopItem.products[productIndex];
        final updatedProduct = existingProduct.copyWith(
          quantity: existingProduct.quantity + 1,
        );

        final updatedProducts = List<Product>.from(existingShopItem.products);
        updatedProducts[productIndex] = updatedProduct;

        final updatedTotalAmount =
            existingShopItem.totalAmount -
            existingProduct.price +
            updatedProduct.price;

        final updatedShopItem = BasketShopItem(
          shop: existingShopItem.shop,
          products: updatedProducts,
          totalAmount: updatedTotalAmount,
          deliveryType: existingShopItem.deliveryType,
          deliveryCost: existingShopItem.deliveryCost,
        );

        List<BasketShopItem> updatedShopItems = List<BasketShopItem>.from(
          state.shopItems,
        );
        updatedShopItems[existingShopIndex] = updatedShopItem;

        state = BasketState(shopItems: updatedShopItems);
      }
    }
  }

  void onMinusCount(Product product, String shopId) {
    /// Поиск товара и магазина в корзине
    /// Увеличивает количество товара в корзине на 1
    final existingShopIndex = state.shopItems.indexWhere(
      (item) => item.shop.id == shopId,
    );
    if (existingShopIndex != -1) {
      final existingShopItem = state.shopItems[existingShopIndex];
      final productIndex = existingShopItem.products.indexWhere(
        (p) => p.propertyUuid == product.propertyUuid,
      );

      if (productIndex != -1) {
        final existingProduct = existingShopItem.products[productIndex];

        if (existingProduct.quantity > 0) {
          final updatedProduct = existingProduct.copyWith(
            quantity: existingProduct.quantity - 1,
          );

          final updatedProducts = List<Product>.from(existingShopItem.products);
          updatedProducts[productIndex] = updatedProduct;

          final updatedTotalAmount =
              existingShopItem.totalAmount -
              existingProduct.price * updatedProduct.quantity;

          final updatedShopItem = BasketShopItem(
            shop: existingShopItem.shop,
            deliveryType: existingShopItem.deliveryType,

            products: updatedProducts,
            totalAmount: updatedTotalAmount,
            deliveryCost: existingShopItem.deliveryCost,
          );

          List<BasketShopItem> updatedShopItems = List<BasketShopItem>.from(
            state.shopItems,
          );
          updatedShopItems[existingShopIndex] = updatedShopItem;

          state = BasketState(shopItems: updatedShopItems);
        }
      }
    }
  }
}
