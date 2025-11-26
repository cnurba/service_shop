import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:service_shop/app/profile/application/order_history/order_history_controller.dart';
import 'package:service_shop/app/profile/application/order_history/order_history_state.dart';
import 'package:service_shop/app/profile/domain/repositories/i_profile_repository.dart';
import 'package:service_shop/injection.dart';

final orderHistoryProvider =
    StateNotifierProvider<OrderHistoryController, OrderHistoryState>((ref) {
      return OrderHistoryController(getIt<IProfileRepository>());
    });
