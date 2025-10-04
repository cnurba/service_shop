
import 'package:flutter/material.dart';

class BasketScreen extends StatelessWidget {
  const BasketScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Basket Screen'),
      ),
      body: const Center(
        child: Text('This is the Basket Screen'),
      ),
    );
  }
}
