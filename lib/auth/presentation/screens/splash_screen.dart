import 'package:flutter/material.dart';
import 'package:service_shop/core/presentation/appbar/login_appbar.dart';
import 'package:service_shop/core/presentation/theme/colors.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ServiceColors.primaryColor,
      body: Center(child: LoginAppbar()),
    );
  }
}
