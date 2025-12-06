import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:service_shop/auth/application/send_sms/send_sms_state.dart';
import 'package:service_shop/auth/domain/repositories/i_auth_repository.dart';
import 'package:service_shop/core/enum/state_type.dart';
import 'package:service_shop/injection.dart';

final sendSmsProvider = StateNotifierProvider<SendSmsController, SendSmsState>((
  ref,
) {
  final authRepository = getIt<IAuthRepository>();
  return SendSmsController(authRepository);
});

class SendSmsController extends StateNotifier<SendSmsState> {
  final IAuthRepository _authRepository;

  SendSmsController(this._authRepository) : super(SendSmsState.initial());

  Future<void> sendSms(String phoneNumber) async {
    state = state.copyWith(
      stateType: StateType.loading,
      phoneNumber: phoneNumber,
    );
    final success = await _authRepository.sendSms(phoneNumber);
    if (success) {
      state = state.copyWith(stateType: StateType.loaded);
    } else {
      state = state.copyWith(
        stateType: StateType.error,
        errorText: 'Failed to send SMS. Please try again.',
      );
    }
  }
}
