import 'package:equatable/equatable.dart';
import 'package:service_shop/app/core/models/products/product.dart';
import 'package:service_shop/core/enum/state_type.dart';

class FavoritesProductState extends Equatable {
  final StateType status;
  final List<Product> favoriteProducts;
  final String? error;

  const FavoritesProductState({
    this.status = StateType.initial,
    this.error,
    required this.favoriteProducts,
  });

  factory FavoritesProductState.initial() {
    return const FavoritesProductState(favoriteProducts: []);
  }

  FavoritesProductState copyWith({
    StateType? status,
    String? error,
    List<Product>? favoriteProducts,
  }) {
    return FavoritesProductState(
      status: status ?? this.status,
      favoriteProducts: favoriteProducts ?? this.favoriteProducts,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [status, error, favoriteProducts];
}
