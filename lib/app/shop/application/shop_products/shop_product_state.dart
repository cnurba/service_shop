import 'package:equatable/equatable.dart';
import '../../domain/models/shop_products.dart';

enum ShopProductStatus { initial, loading, loaded, error }

class ShopProductState extends Equatable {
  final List<ShopProductCategory> categories;
  final ShopProductStatus status;
  final String? error;

  const ShopProductState({
    this.categories = const [],
    this.status = ShopProductStatus.initial,
    this.error,
  });

  ShopProductState copyWith({
    List<ShopProductCategory>? categories,
    ShopProductStatus? status,
    String? error,
  }) {
    return ShopProductState(
      categories: categories ?? this.categories,
      status: status ?? this.status,
      error: error,
    );
  }

  @override
  List<Object?> get props => [categories, status, error];
}

