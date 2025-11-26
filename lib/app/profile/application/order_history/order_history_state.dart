import 'package:service_shop/app/profile/domain/models/order_model.dart';
import 'package:service_shop/core/enum/state_type.dart';

enum OrderHistoryStatus { initial, loading, loaded, error }

class OrderHistoryState {
  final List<OrderModelInfo> orders;
  final StateType status;
  final String? error;

  const OrderHistoryState({
    this.orders = const [],
    this.status = StateType.initial,
    this.error,
  });

  OrderHistoryState copyWith({
    List<OrderModelInfo>? orders,
    StateType? status,
    String? error,
  }) {
    return OrderHistoryState(
      orders: orders ?? this.orders,
      status: status ?? this.status,
      error: error,
    );
  }

  List<Object?> get props => [orders, status, error];
}
