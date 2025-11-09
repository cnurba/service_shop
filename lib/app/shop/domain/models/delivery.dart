import 'package:equatable/equatable.dart';

class Delivery extends Equatable {
  final String type;
  final double cost;

  const Delivery({required this.type, required this.cost});

  factory Delivery.fromJson(Map<String, dynamic> json) {
    return Delivery(
      type: json['type'] ?? '',
      cost: (json['cost'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {'type': type, 'cost': cost};
  }

  @override
  List<Object?> get props => [type, cost];
}
