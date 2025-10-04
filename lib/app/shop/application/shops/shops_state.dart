import 'package:equatable/equatable.dart';
import '../../domain/models/shop.dart';

enum ShopsStatus { initial, loading, loaded, error }

class ShopsState extends Equatable {
  final List<Shop> shops;
  final ShopsStatus status;
  final String? error;

  const ShopsState({
    this.shops = const [],
    this.status = ShopsStatus.initial,
    this.error,
  });

  ShopsState copyWith({
    List<Shop>? shops,
    ShopsStatus? status,
    String? error,
  }) {
    return ShopsState(
      shops: shops ?? this.shops,
      status: status ?? this.status,
      error: error,
    );
  }

  @override
  List<Object?> get props => [shops, status, error];
}

