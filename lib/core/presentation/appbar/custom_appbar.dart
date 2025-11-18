import 'package:flutter/material.dart';
import 'package:service_shop/core/presentation/theme/colors.dart';

AppBar customAppBar(
  BuildContext context,
  String title, {
  bool showBack = true,
  List<Widget>? actions,
}) {
  return AppBar(
    backgroundColor: ServiceColors.white,
    title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
    // centerTitle: true,
    leading: showBack
        ? IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          )
        : null,
    actions: actions,
  );
}
