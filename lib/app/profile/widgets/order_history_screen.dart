import 'package:flutter/material.dart';

class OrderHistoryScreen extends StatelessWidget {
  const OrderHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('История заказов'),
          bottom: const TabBar(
            labelColor: Colors.black,
            indicatorColor: Colors.black,
            tabs: [
              Tab(icon: Icon(Icons.access_time), text: 'В обработке'),
              Tab(icon: Icon(Icons.local_shipping_outlined), text: 'В пути'),
              Tab(icon: Icon(Icons.verified_user_outlined), text: 'Доставлено'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            OrderList(status: 'processing'),
            OrderList(status: 'onWay'),
            OrderList(status: 'delivered'),
          ],
        ),
      ),
    );
  }
}

class OrderList extends StatelessWidget {
  final String status;
  const OrderList({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    final orders = [
      {
        'number': '№ 12345',
        'date': '09 сент.',
        'items': 'и еще 2 товара',
        'price': '2 500 с',
        'image': 'assets/logo/placeholder.png',
      },
      {
        'number': '№ 12344',
        'date': '07 сент.',
        'items': 'и еще 1 товар',
        'price': '5 850 с',
        'image': 'assets/logo/placeholder.png',
      },
    ];

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: orders.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final order = orders[index];
        return OrderCard(
          number: order['number']!,
          date: order['date']!,
          items: order['items']!,
          price: order['price']!,
          image: order['image']!,
        );
      },
    );
  }
}

class OrderCard extends StatelessWidget {
  final String number;
  final String date;
  final String items;
  final String price;
  final String image;

  const OrderCard({
    super.key,
    required this.number,
    required this.date,
    required this.items,
    required this.price,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(number, style: const TextStyle(fontWeight: FontWeight.bold)),
              Text('Подробнее', style: TextStyle(color: Colors.blue.shade600)),
            ],
          ),
          Text(date, style: const TextStyle(color: Colors.grey, fontSize: 12)),
          const SizedBox(height: 8),

          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  image,
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(items, style: const TextStyle(fontSize: 14)),
              ),
              Text(
                price,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
