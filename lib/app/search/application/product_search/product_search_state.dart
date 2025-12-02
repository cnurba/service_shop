
import 'package:equatable/equatable.dart';
import 'package:service_shop/app/core/models/products/product.dart';
import 'package:service_shop/core/enum/state_type.dart';

class ProductSearchState extends Equatable {
  final List<Product> products;
  final StateType status;
  final String? error;

  const ProductSearchState({
    this.products = const [],
    this.status = StateType.initial,
    this.error,
  });

  factory ProductSearchState.initial() {
    return const ProductSearchState();
  }

  ProductSearchState copyWith({
    List<Product>? products,
    StateType? status,
    String? error,
  }) {
    return ProductSearchState(
      products: products ?? this.products,
      status: status ?? this.status,
      error: error,
    );
  }

  @override
  List<Object?> get props => [products, status, error];
}

