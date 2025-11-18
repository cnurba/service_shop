import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:service_shop/app/profile/application/profile_edit/profile_edit_provider.dart';
import 'package:service_shop/app/profile/presentation/widgets/gender_selector.dart';
import 'package:service_shop/app/profile/presentation/widgets/profile_field_updater.dart';
import 'package:service_shop/app/profile/presentation/widgets/text_field_with_status.dart';

class ProfileTextField extends ConsumerWidget {
  const ProfileTextField({
    required this.label,
    required this.fieldKey,
    this.suffixIcon,
    this.obscureText = false,
    this.statusText,
    super.key,
  });

  final String label;
  final String fieldKey;
  final Widget? suffixIcon;
  final bool obscureText;
  final String? statusText;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(profileEditProvider);
    final controller = ref.read(profileEditProvider.notifier);

    final textController = TextEditingController(
      text: {
        'firstName': state.firstName,
        'lastName': state.lastName,
        'birthDate': state.birthDate,
        'gender': state.gender,
        'phone': state.phone,
        'email': state.email,
        'password': state.password,
      }[fieldKey],
    );

    Widget? effectiveSuffixIcon = suffixIcon;
    VoidCallback? onTapIcon;

    // Handle date field
    if (fieldKey == 'birthDate') {
      effectiveSuffixIcon = const Icon(Icons.date_range);
      onTapIcon = () async {
        DateTime? picked = await showDatePicker(
          context: context,
          initialDate: state.birthDate.isNotEmpty
              ? DateTime.tryParse(state.birthDate) ?? DateTime(2000)
              : DateTime(2000),
          firstDate: DateTime(1900),
          lastDate: DateTime.now(),
        );

        if (picked != null) {
          final formattedDate =
              "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
          controller.setBirthDate(formattedDate);
        }
      };
    }
    // Handle gender field
    else if (fieldKey == 'gender') {
      effectiveSuffixIcon = const Icon(Icons.arrow_forward_ios);
      onTapIcon = () async {
        final selected = await selectGender(context);
        if (selected != null) {
          controller.setGender(selected);
        }
      };
    }

    (value) => updateProfileField(controller, fieldKey, value);

    final textField = TextField(
      controller: textController,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        suffixIcon: effectiveSuffixIcon != null
            ? GestureDetector(onTap: onTapIcon, child: effectiveSuffixIcon)
            : null,
      ),
      obscureText: obscureText,
      onChanged: (value) => updateProfileField(controller, fieldKey, value),
      readOnly: fieldKey == 'birthDate' || fieldKey == 'gender',
    );

    if (statusText != null) {
      return TextFieldWithStatus(textField: textField, statusText: statusText!);
    } else {
      return textField;
    }
  }
}
