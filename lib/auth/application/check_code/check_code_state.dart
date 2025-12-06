import 'package:equatable/equatable.dart';
import 'package:service_shop/core/enum/state_type.dart';

class CheckCodeState extends Equatable {
  final StateType stateType;
  final String code;
  final String? errorText;

  const CheckCodeState({
    required this.stateType,
    required this.code,
    this.errorText,
  });

  factory CheckCodeState.initial() {
    return const CheckCodeState(
      stateType: StateType.initial,
      code: '',
      errorText: null,
    );
  }

  CheckCodeState copyWith({
    StateType? stateType,
    String? code,
    String? errorText,
  }) {
    return CheckCodeState(
      stateType: stateType ?? this.stateType,

      code: code ?? this.code,
      errorText: errorText ?? this.errorText,
    );
  }

  @override
  List<Object?> get props => [stateType, code, errorText];
}
