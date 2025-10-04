import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'auth/application/auth_provider/auth_provider.dart';
import 'core/presentation/theme/app_theme.dart';
import 'home_screen.dart';

class ServiceClientApp extends ConsumerStatefulWidget {
  const ServiceClientApp({super.key});

  @override
  ConsumerState<ServiceClientApp> createState() => _ServiceClientAppState();
}

class _ServiceClientAppState extends ConsumerState<ServiceClientApp> {

  @override
  void initState() {
    Future.microtask(() {
      ref.read(authProvider.notifier).enter();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: Consumer(
        builder: (context, ref, child) {

          final authStateValue = ref.watch(authProvider);
          return authStateValue.when(
            initial: () => const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            ),
            loading: () => const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            ),
            authenticated: () => ServiceShopAppScreen(),
            unauthenticated: () => const Scaffold(
              body: Center(child: Text('Unauthenticated - Login Screen')),
            ),
          );
        },
      ),
    );
  }
}
