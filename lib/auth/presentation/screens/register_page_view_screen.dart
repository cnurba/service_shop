
import 'package:flutter/material.dart';
import 'package:service_shop/auth/presentation/screens/register_pages/new_password_screen.dart';
import 'package:service_shop/auth/presentation/screens/register_pages/registration_screen.dart';
import 'package:service_shop/auth/presentation/screens/register_pages/submit_number_screen.dart';
import 'package:service_shop/auth/presentation/screens/register_pages/success_password_screen.dart';

class RegisterPageViewScreen extends StatefulWidget {
  const RegisterPageViewScreen({super.key});

  @override
  State<RegisterPageViewScreen> createState() => _RegisterPageViewScreenState();
}

class _RegisterPageViewScreenState extends State<RegisterPageViewScreen> {


  final List<Widget> _pages= [
    RegistrationScreen(),
    SubmitNumberScreen(phoneNumber:''),
    NewPasswordScreen(),
    SuccessPasswordScreen(),

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

    );
  }
}
