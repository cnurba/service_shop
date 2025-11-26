import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:service_shop/app/profile/application/order_history/order_history_state.dart';
import 'package:service_shop/app/profile/domain/repositories/i_profile_repository.dart';
import 'package:service_shop/core/enum/state_type.dart';

class OrderHistoryController extends StateNotifier<OrderHistoryState> {
  final IProfileRepository repository;
  OrderHistoryController(this.repository) : super(const OrderHistoryState());

  Future<void> loadOrders(String status) async {
    state = state.copyWith(status: StateType.loading, error: null);
    try {
      final orders = await repository.getOrderInfoList(status);
      state = state.copyWith(orders: orders, status: StateType.loaded);
    } catch (e) {
      state = state.copyWith(status: StateType.error, error: e.toString());
    }
  }
}
