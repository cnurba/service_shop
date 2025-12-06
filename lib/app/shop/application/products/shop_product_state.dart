import 'package:equatable/equatable.dart';
import 'package:service_shop/app/core/models/products/product_category.dart';
import 'package:service_shop/core/enum/state_type.dart';

class ShopProductState extends Equatable {
  final List<ProductCategory> categories;
  final StateType status;
  final String? error;

  const ShopProductState({
    this.categories = const [],
    this.status = StateType.initial,
    this.error,
  });

  ShopProductState copyWith({
    List<ProductCategory>? categories,
    StateType? status,
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

