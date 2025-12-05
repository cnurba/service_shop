
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:service_shop/app/profile/presentation/widgets/status_container.dart';

import '../theme/colors.dart';

class PasswordField extends StatefulWidget {
  const PasswordField({
    super.key,
    required this.onChanged,
    this.errorText,
    this.focusNode,
    this.onEditingComplete,
    this.validator,
  });

  final ValueChanged<String>? onChanged;
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

          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: TextFormField(
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
                    labelText: 'Пароль',
                    labelStyle: const TextStyle(color: ServiceColors.black),
                    errorText: widget.errorText,
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(6)),
                      borderSide: BorderSide.none,
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() => isObscured = !isObscured);
                      },
                      icon: isObscured
                          ? const Icon(CupertinoIcons.eye_slash)
                          : const Icon(CupertinoIcons.eye_fill),
                    ),
                  ),
                  onChanged: widget.onChanged,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
              ),

              const SizedBox(width: 8),

              StatusContainer(text: 'Сменить пароль'),
            ],
          )
        ],

      ) : Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

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
                labelText: 'Пароль',
                labelStyle: const TextStyle(color: ServiceColors.black),
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