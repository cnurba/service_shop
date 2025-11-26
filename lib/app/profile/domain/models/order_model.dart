class OrderModelInfo {
  final String id;
  final String number;
  final DateTime date;
  final double amount;
  final int count;

  const OrderModelInfo({
    required this.id,
    required this.number,
    required this.date,
    required this.amount,
    required this.count,
  });

  factory OrderModelInfo.fromJson(Map<String, dynamic> json) {
    return OrderModelInfo(
      id: json['id'] ?? '',
      number: json['number'] ?? '',
      date: DateTime.parse(json['date']),
      amount: (json['amount'] ?? 0).toDouble(),
      count: json['count'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'number': number,
      'date': date.toIso8601String(),
      'amount': amount,
      'count': count,
    };
  }
}
