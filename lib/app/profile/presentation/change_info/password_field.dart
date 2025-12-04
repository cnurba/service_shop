
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/presentation/theme/colors.dart';

class PasswordField extends StatefulWidget {
  const PasswordField({
    super.key,
    required this.onChanged,
    required this.title,
    this.errorText,
    this.focusNode,
    this.onEditingComplete,
    this.validator,
  });

  final ValueChanged<String>? onChanged;
  final String title;
  final String? errorText;
  final FocusNode? focusNode;
  final Function()? onEditingComplete;
  final String? Function(String?)? validator;

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool isObscured = true;
  
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final currentWidth = MediaQuery.of(context).size.width;
    return Form(
      key: formKey,
      child: currentWidth  > 375 ? Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  // color: MurasColors.textColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
          ),
          const SizedBox(height: 8),
          TextFormField(
            style: const TextStyle(fontSize: 24),
            autofocus: false,
            focusNode: widget.focusNode,
            keyboardType: TextInputType.visiblePassword,
            obscureText: isObscured,
            onEditingComplete: widget.onEditingComplete,
            validator: widget.validator,
            decoration: InputDecoration(
                fillColor: ServiceColors.white,
                filled: true,
                errorText: widget.errorText,
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(6)),
                  borderSide: BorderSide.none,
                ),
                suffixIcon: IconButton(
                  onPressed: () {
                    if (isObscured) {
                      isObscured = false;
                    } else {
                      isObscured = true;
                    }

                    setState(() {});
                  },
                  icon: isObscured
                      ? const Icon(CupertinoIcons.eye_slash)
                      : const Icon(CupertinoIcons.eye_fill),
                )),
            onChanged: widget.onChanged,
            autovalidateMode: AutovalidateMode.onUserInteraction,
          ),
        ],

      ) : Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
          ),
          const SizedBox(height: 8),
          TextFormField(
            style: const TextStyle(fontSize: 12),
            autofocus: false,
            focusNode: widget.focusNode,
            keyboardType: TextInputType.visiblePassword,
            obscureText: isObscured,
            onEditingComplete: widget.onEditingComplete,
            validator: widget.validator,
            decoration: InputDecoration(
                fillColor: ServiceColors.white,
                filled: true,
                errorText: widget.errorText,
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                  borderSide: BorderSide.none,
                ),
                suffixIcon: IconButton(
                  onPressed: () {
                    if (isObscured) {
                      isObscured = false;
                    } else {
                      isObscured = true;
                    }

                    setState(() {});
                  },
                  icon: isObscured
                      ? const Icon(CupertinoIcons.eye_slash)
                      : const Icon(CupertinoIcons.eye_fill),
                )),
            onChanged: widget.onChanged,
            autovalidateMode: AutovalidateMode.onUserInteraction,
          ),
        ],
      ),
    );
  }
}