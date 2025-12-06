import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:service_shop/app/profile/domain/models/user_edit_model.dart';
import 'package:service_shop/app/profile/profile_edit_screen.dart';
import 'package:service_shop/app/profile/presentation/screens/about_app_screen.dart';
import 'package:service_shop/app/profile/presentation/screens/feedback_screen.dart';
import 'package:service_shop/app/profile/presentation/screens/address/my_adress_screen.dart';
import 'package:service_shop/app/profile/presentation/screens/order_history_screen.dart';
import 'package:service_shop/app/profile/presentation/screens/payment_method_screen.dart';
import 'package:service_shop/app/profile/presentation/screens/settings_screen.dart';
import 'package:service_shop/app/profile/presentation/widgets/profile_menu_tile.dart';
import 'package:service_shop/app/profile/presentation/widgets/status_container.dart';
import 'package:service_shop/app/profile/registered_profile_screen.dart';
import 'package:service_shop/app/profile/unregistered_profile_screen.dart';
import 'package:service_shop/core/extansions/router_extension.dart';
import 'package:service_shop/core/presentation/appbar/custom_appbar.dart';
import 'package:service_shop/core/presentation/failure/failure.dart';
import 'package:service_shop/core/presentation/failure/loader.dart';

import 'application/current_user/current_user.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final userData = ref.watch(currentUserProvider);
        return userData.when(
          data: (UserProfile data) {
            if (data.isUserRegistered) {
              return RegisteredProfileScreen(profile: data);
            }
            return UnregisteredProfileScreen();
          },
          error: (error, stackTrace) =>
              FailureWidget(withScaffold: true, message: error.toString()),
          loading: () => Loader(withScaffold: true),
        );
      },
    );
  }
}
