import 'package:flutter/material.dart';

class FailureWidget extends StatelessWidget {
  const FailureWidget({
    super.key,
    this.withScaffold = false,
    required this.message,
    this.onRetry,
  });

  final bool withScaffold;
  final String message;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return withScaffold
        ? Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(message),
                  if (onRetry != null)
                    TextButton(onPressed: onRetry, child: Text("Повторить")),
                ],
              ),
            ),
          )
        : Center(child: Text(message));
  }
}
