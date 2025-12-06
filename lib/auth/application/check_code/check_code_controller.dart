import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:service_shop/auth/application/check_code/check_code_state.dart';
import 'package:service_shop/auth/domain/repositories/i_auth_repository.dart';
import 'package:service_shop/core/enum/state_type.dart';
import 'package:service_shop/injection.dart';

final checkCodeProvider =
    StateNotifierProvider<CheckCodeController, CheckCodeState>((ref) {
      final authRepository = getIt<IAuthRepository>();
      return CheckCodeController(authRepository);
    });

class CheckCodeController extends StateNotifier<CheckCodeState> {
  final IAuthRepository _authRepository;

  CheckCodeController(this._authRepository) : super(CheckCodeState.initial());

  void resetState() {
    state = CheckCodeState.initial();
  }

  Future<void> verifySms(String code, String phoneNumber) async {
    state = state.copyWith(stateType: StateType.loading, code: code);
    final success = await _authRepository.verifySms(code, phoneNumber);
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
