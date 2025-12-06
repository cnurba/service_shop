import 'package:equatable/equatable.dart';
import 'package:service_shop/core/enum/state_type.dart';

class SendSmsState extends Equatable {
  final StateType stateType;
  final String phoneNumber;
  final String? errorText;

  const SendSmsState({
    required this.stateType,
    required this.phoneNumber,
    this.errorText,
  });

  factory SendSmsState.initial() {
    return const SendSmsState(
      stateType: StateType.initial,
      phoneNumber: '',
      errorText: null,
    );
  }

  SendSmsState copyWith({
    StateType? stateType,
    String? phoneNumber,
    String? errorText,
  }) {
    return SendSmsState(
      stateType: stateType ?? this.stateType,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      errorText: errorText ?? this.errorText,
    );
  }

  @override
  List<Object?> get props => [stateType, phoneNumber, errorText];
}
