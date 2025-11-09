import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:service_shop/app/basket/application/basket_provider/basket_state.dart';
import 'package:service_shop/app/basket/application/checkout_provider/checkout_state.dart';
import 'package:service_shop/app/core/models/products/product.dart';
import 'package:service_shop/app/shop/domain/models/shop.dart';
import 'package:service_shop/core/enum/delivery_type.dart';
import 'package:service_shop/core/enum/payment_type.dart';

final checkoutProvider =
  StateNotifierProvider<CheckoutController, CheckoutState>((ref) {
      return CheckoutController();
    });

class CheckoutController extends StateNotifier<CheckoutState>{
  CheckoutController(): super(CheckoutState.initial());

  void initialize(BasketState basketState){
    /// Инициализация состояния оформления заказа на основе состояния корзины
    /// Копируем список магазинов и товаров из корзины в состояние оформления заказа
    /// Это позволяет начать оформление заказа с текущего содержимого корзины
  }

  void changePaymentType(PaymentType paymentType){
    state = state.copyWith(paymentType: paymentType);
  }

  void changeCombinedDelivery(bool isCombined){
    state = state.copyWith(isCombinedDelivery: isCombined);
  }
  void changeDeliveryType(DeliveryType deliveryType, String shopId){
    final existingShopIndex = state.shopItems.indexWhere((item) => item.shopId == shopId);
    if (existingShopIndex != -1) {
      final existingShopItem = state.shopItems[existingShopIndex];
      final updatedShopItem = existingShopItem.copyWith(deliveryType: deliveryType);
      List<CheckoutShopItem> updatedShopItems = List<CheckoutShopItem>.from(state.shopItems);
      updatedShopItems[existingShopIndex] = updatedShopItem;
      state = state.copyWith(shopItems: updatedShopItems);
    }
  }

  void add (Product product, Shop shop){
    // Проверяем, есть ли уже магазин в корзине
    final existingShopIndex = state.shopItems.indexWhere((item) => item.shopId == shop.id);

    if (existingShopIndex != -1) {
      // Магазин уже есть, добавляем товар в существующий магазин
      final existingShopItem = state.shopItems[existingShopIndex];

      /// Проверяем есть ли уже такой товар в корзине этого магазина
      /// Если есть , тогда просто установливаем количество последнего товара
      /// иначе добавляем новый товар в список

      final productIndex = existingShopItem.products.indexWhere((p) => p.propertyUuid == product.propertyUuid);
      List<CheckoutShopItem> updatedShopItems = List<CheckoutShopItem>.from(state.shopItems);

      if (productIndex != -1) {
        // Товар уже есть, обновляем его количество
        final existingProduct = existingShopItem.products[productIndex];
        final updatedProduct = existingProduct.copyWith(count: product.quantity+1);

        final updatedProducts = List<Product>.from(existingShopItem.products);
        updatedProducts[productIndex] = updatedProduct;

        final updatedTotalAmount = existingShopItem.totalAmount - existingProduct.price + updatedProduct.price;

        final updatedShopItem = CheckoutShopItem(
          shopId: existingShopItem.shopId,
          shopName: existingShopItem.shopName,
          shopImageUrl: existingShopItem.shopImageUrl,
          products: updatedProducts,
          totalAmount: updatedTotalAmount,
          deliveryType: existingShopItem.deliveryType,
        );

        updatedShopItems[existingShopIndex] = updatedShopItem;
      } else {
        // Товара нет, добавляем его в список
        final updatedProducts = List<Product>.from(existingShopItem.products)..add(product);
        final updatedTotalAmount = existingShopItem.totalAmount + product.price;

        final updatedShopItem = CheckoutShopItem(
          shopId: existingShopItem.shopId,
          shopName: existingShopItem.shopName,
          shopImageUrl: existingShopItem.shopImageUrl,
          products: updatedProducts,
          totalAmount: updatedTotalAmount,
          deliveryType: existingShopItem.deliveryType,
        );

        updatedShopItems[existingShopIndex] = updatedShopItem;
      }

      state = state.copyWith(shopItems: updatedShopItems);///CheckoutState(shopItems: updatedShopItems, paymentType: state.paymentType);
    } else {
      // Магазин отсутствует, создаем новый элемент магазина в корзине
      final newShopItem = CheckoutShopItem(
        shopId: shop.id,
        shopName: shop.name,
        shopImageUrl: shop.imageUrl,
        products: [product],
        totalAmount: product.price,
        deliveryType: DeliveryType.pickup,
      );

      state = state.copyWith(
        shopItems: [...state.shopItems, newShopItem],
      );
    }

  }

  void remove(Product product, String shopId) {
    /// Проверяем, есть ли магазин в корзине
    /// Если есть, то ищем товар в списке товаров магазина
    /// Если товар найден, то удаляем его из списка товаров магазина

    final existingShopIndex = state.shopItems.indexWhere((item) => item.shopId == shopId);
    if (existingShopIndex != -1) {
      final existingShopItem = state.shopItems[existingShopIndex];
      final productIndex = existingShopItem.products.indexWhere((p) => p.propertyUuid == product.propertyUuid);

      if (productIndex != -1) {
        final updatedProducts = List<Product>.from(existingShopItem.products)..removeAt(productIndex);
        final updatedTotalAmount = existingShopItem.totalAmount - product.price;

        List<CheckoutShopItem> updatedShopItems = List<CheckoutShopItem>.from(state.shopItems);

        if (updatedProducts.isEmpty) {
          // Если после удаления товаров магазин пуст, удаляем магазин из корзины
          updatedShopItems.removeAt(existingShopIndex);
        } else {
          final updatedShopItem = CheckoutShopItem(
            shopId: existingShopItem.shopId,
            shopName: existingShopItem.shopName,
            shopImageUrl: existingShopItem.shopImageUrl,
            products: updatedProducts,
            totalAmount: updatedTotalAmount, deliveryType: existingShopItem.deliveryType,
          );

          updatedShopItems[existingShopIndex] = updatedShopItem;
        }

        state = state.copyWith(shopItems: updatedShopItems);//CheckoutState(shopItems: updatedShopItems);
      }
    }

  }

  void onLike(Product product, String shopId) {}

  void onAddCount(Product product, String shopId) {
    /// Поиск товара и магазина в корзине
    /// Увеличивает количество товара в корзине на 1
    final existingShopIndex = state.shopItems.indexWhere((item) => item.shopId == shopId);
    if (existingShopIndex != -1) {
      final existingShopItem = state.shopItems[existingShopIndex];
      final productIndex = existingShopItem.products.indexWhere((p) =>
        p.propertyUuid == product.propertyUuid);

      if(productIndex!=-1){
        final existingProduct = existingShopItem.products[productIndex];
        final updatedProduct = existingProduct.copyWith(quantity: existingProduct.quantity + 1);

        final updatedProducts = List<Product>.from(existingShopItem.products);
        updatedProducts[productIndex] = updatedProduct;

        final updatedTotalAmount = existingShopItem.totalAmount - existingProduct.price + updatedProduct.price;

        final updatedShopItem = CheckoutShopItem(
          shopId: existingShopItem.shopId,
          shopName: existingShopItem.shopName,
          shopImageUrl: existingShopItem.shopImageUrl,
          products: updatedProducts,
          totalAmount: updatedTotalAmount,
          deliveryType: existingShopItem.deliveryType,
        );

        List<CheckoutShopItem> updatedShopItems = List<CheckoutShopItem>.from(state.shopItems);
        updatedShopItems[existingShopIndex] = updatedShopItem;

        state = state.copyWith(shopItems: updatedShopItems);//CheckoutState(shopItems: updatedShopItems);
      }

    }

  }

  void onMinusCount(Product product, String shopId) {
    /// Поиск товара и магазина в корзине
    /// Увеличивает количество товара в корзине на 1
    final existingShopIndex = state.shopItems.indexWhere((item) => item.shopId == shopId);
    if (existingShopIndex != -1) {
      final existingShopItem = state.shopItems[existingShopIndex];
      final productIndex = existingShopItem.products.indexWhere((p) =>
        p.propertyUuid == product.propertyUuid);

      if(productIndex!=1){
        final existingProduct = existingShopItem.products[productIndex];

        if(existingProduct.count>0){
          final updatedProduct = existingProduct.copyWith(quantity: existingProduct.quantity - 1);

          final updatedProducts = List<Product>.from(existingShopItem.products);
          updatedProducts[productIndex] = updatedProduct;

          final updatedTotalAmount = existingShopItem.totalAmount - existingProduct.price + updatedProduct.price;

          final updatedShopItem = CheckoutShopItem(
            shopId: existingShopItem.shopId,
            shopName: existingShopItem.shopName,
            shopImageUrl: existingShopItem.shopImageUrl,
            products: updatedProducts,
            totalAmount: updatedTotalAmount,
            deliveryType: existingShopItem.deliveryType,
          );

          List<CheckoutShopItem> updatedShopItems = List<CheckoutShopItem>.from(state.shopItems);
          updatedShopItems[existingShopIndex] = updatedShopItem;

          state = state.copyWith(shopItems: updatedShopItems); //CheckoutState(shopItems: updatedShopItems);
        }

      }

    }

  }

}