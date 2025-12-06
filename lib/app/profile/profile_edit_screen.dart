import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:service_shop/app/profile/domain/models/user_edit_model.dart';
import 'package:service_shop/app/profile/presentation/widgets/change_photo.dart';
import 'package:service_shop/core/enum/state_type.dart';
import 'package:service_shop/core/presentation/buttons/custom_button.dart';
import 'package:service_shop/core/presentation/fields/date_field.dart';
import 'package:service_shop/core/presentation/fields/email_field.dart';
import 'package:service_shop/core/presentation/fields/gender_field.dart';
import 'package:service_shop/core/presentation/fields/password_field.dart';
import 'package:service_shop/core/presentation/fields/phone_field.dart';
import 'package:service_shop/core/presentation/appbar/custom_appbar.dart';
import 'package:service_shop/core/presentation/fields/text_field.dart';

import 'application/current_user/current_user.dart';
import 'application/profile_edit/profile_edit_provider.dart';

class ProfileEditScreen extends ConsumerStatefulWidget {
  const ProfileEditScreen({super.key});

  @override
  ConsumerState<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends ConsumerState<ProfileEditScreen> {
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userProfileState = ref.watch(profileEditProvider);
    final userProfile = userProfileState.userProfile;

    /// check if stateType is loaded then go back
    if (userProfileState.status == StateType.loaded) {
      Future.microtask(() {
        ref.refresh(currentUserProvider);
        ref.read(profileEditProvider.notifier).resetState();
        Navigator.of(context).pop();
      });
    }

    return Scaffold(
      appBar: customAppBar(context, "Мои данные", showBack: false),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ChangePhoto(imageUrl: userProfile.imageUrl),
              AppTextField(
                labelText: 'Имя',
                initialValue: userProfile.firstName,
                prefixIcon: Icons.person_outline_rounded,
                onChanged: (value) {
                  ref.read(profileEditProvider.notifier).setFirstName(value);
                },
              ),
              AppTextField(
                labelText: 'Фамилия',
                initialValue: userProfile.lastName,
                prefixIcon: Icons.person_outline_rounded,
                onChanged: (value) {
                  ref.read(profileEditProvider.notifier).setFirstName(value);
                },
              ),
              DateField(
                title: "Дата рожения",
                initialDate: userProfile.birthDate,
                onChanged: (value) {
                  ref.read(profileEditProvider.notifier).setBirthDate(value);
                },
              ),
              GenderField(
                initialText: userProfile.gender,
                onChanged: (value) {
                  ref.read(profileEditProvider.notifier).setGender(value);
                },
              ),

              PhoneField(
                initialValue: userProfile.phone,
                onChanged: (value) {
                  ref.read(profileEditProvider.notifier).setPhone(value);
                },
              ),

              EmailField(
                controller: TextEditingController(text: userProfile.email),
                onChanged: (String value) {
                  ref.read(profileEditProvider.notifier).setEmail(value);
                },
              ),
              // PasswordField(title: "Пароль", onChanged: (String value) {}),
              //
              // PasswordField(
              //   title: "Повторите пароль",
              //   onChanged: (String value) {},
              // ),
              SizedBox(height: 32),
              CustomButton(
                text: "Сохранить изменения",
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    ref.read(profileEditProvider.notifier).updateProfile();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
