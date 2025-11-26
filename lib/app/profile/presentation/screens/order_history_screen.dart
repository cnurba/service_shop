import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:service_shop/app/profile/application/order_history/order_history_provider.dart';
import 'package:service_shop/core/enum/state_type.dart';
import 'package:service_shop/core/presentation/theme/colors.dart';

class OrderHistoryScreen extends ConsumerStatefulWidget {
  const OrderHistoryScreen({super.key});

  @override
  ConsumerState<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends ConsumerState<OrderHistoryScreen>
    with SingleTickerProviderStateMixin {
  late TabController controller;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 3, vsync: this);

    controller.addListener(() {
      if (!controller.indexIsChanging) {
        final status = switch (controller.index) {
          0 => 'processing',
          1 => 'onWay',
          2 => 'delivered',
          _ => 'processing',
        };

        ref.read(orderHistoryProvider.notifier).loadOrders(status);
      }
    });

    /// Load first tab initially
    ref.read(orderHistoryProvider.notifier).loadOrders('processing');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('История заказов'),
        bottom: TabBar(
          controller: controller,
          labelColor: Colors.black,
          indicatorColor: Colors.black,
          tabs: const [
            Tab(icon: Icon(Icons.access_time), text: 'В обработке'),
            Tab(icon: Icon(Icons.local_shipping_outlined), text: 'В пути'),
            Tab(icon: Icon(Icons.verified_user_outlined), text: 'Доставлено'),
          ],
        ),
      ),
      body: TabBarView(
        controller: controller,
        children: const [
          OrderList(status: 'processing'),
          OrderList(status: 'onWay'),
          OrderList(status: 'delivered'),
        ],
      ),
    );
  }
}

class OrderList extends ConsumerWidget {
  final String status;
  const OrderList({super.key, required this.status});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(orderHistoryProvider);

    // Load data when tab is opened
    ref.listen(orderHistoryProvider, (_, next) {
      // if first time in tab -> load
      if (next.status == StateType.initial) {
        ref.read(orderHistoryProvider.notifier).loadOrders(status);
      }
    });

    if (state.status == StateType.loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.status == StateType.error) {
      return Center(child: Text('Ошибка: ${state.error}'));
    }

    if (state.orders.isEmpty) {
      return const Center(child: Text('Нет заказов'));
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: state.orders.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final order = state.orders[index];
        return OrderCard(
          number: order.number,
          date: _formatDate(order.date),
          items: 'и еще ${order.count - 1} товара',
          price: '${order.amount.toStringAsFixed(0)} с',
          image: 'assets/logo/placeholder.png', // from API later if needed
        );
      },
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')} ${_ruMonth(date.month)}';
  }

  String _ruMonth(int month) {
    const months = [
      'янв.',
      'февр.',
      'март.',
      'апр.',
      'май',
      'июнь',
      'июль',
      'авг.',
      'сент.',
      'окт.',
      'нояб.',
      'дек.',
    ];
    return months[month - 1];
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
