import 'package:flutter/material.dart';

class Loader extends StatelessWidget {
  const Loader({super.key, this.withScaffold = false});

  final bool withScaffold;

  @override
  Widget build(BuildContext context) {
    return withScaffold
        ? Scaffold(body: Center(child: CircularProgressIndicator.adaptive()))
        : Center(child: CircularProgressIndicator.adaptive());
  }
}
