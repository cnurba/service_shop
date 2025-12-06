import 'package:flutter/material.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key, this.onCodeEntered});

  final void Function(String code)? onCodeEntered;

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final int _length = 4;
  late final List<FocusNode> _focusNodes;
  late final List<TextEditingController> _controllers;

  @override
  void initState() {
    super.initState();
    _focusNodes = List.generate(_length, (_) => FocusNode());
    _controllers = List.generate(_length, (_) => TextEditingController());
    // Optionally focus the first field when the widget appears
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _focusNodes.first.requestFocus();
    });
  }

  @override
  void dispose() {
    for (final node in _focusNodes) {
      node.dispose();
    }
    for (final ctrl in _controllers) {
      ctrl.dispose();
    }
    super.dispose();
  }

  void _handleEditingComplete(int index) {
    if (index < _length - 1) {
      FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
    } else {
      _focusNodes[index].unfocus();
      _maybeSubmitCode();
    }
  }

  void _maybeSubmitCode() {
    final code = _controllers.map((c) => c.text).join();
    if (code.length == _length) {
      widget.onCodeEntered?.call(code);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(_length, (index) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 8),
          width: 50,
          height: 60,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.blue),
            borderRadius: BorderRadius.circular(8),
          ),
          alignment: Alignment.center,
          child: TextField(
            controller: _controllers[index],
            focusNode: _focusNodes[index],
            textAlign: TextAlign.center,
            maxLength: 1,
            keyboardType: TextInputType.number,
            textInputAction: index == _length - 1 ? TextInputAction.done : TextInputAction.next,
            onEditingComplete: () => _handleEditingComplete(index),
            onChanged: (value) {
              if (value.isEmpty) {
                // if user cleared, do nothing (could move focus back on backspace handling)
                return;
              }

              // Handle paste (multiple chars) or single char input
              if (value.length > 1) {
                final chars = value.split('');
                for (var i = 0; i < chars.length && i + index < _length; i++) {
                  _controllers[index + i].text = chars[i];
                }
                final lastIndex = (index + chars.length - 1).clamp(0, _length - 1);
                FocusScope.of(context).requestFocus(_focusNodes[lastIndex]);
              } else {
                // Single character entered -> move to next
                if (index < _length - 1) {
                  FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
                } else {
                  _focusNodes[index].unfocus();
                }
              }

              // After processing input, check if we have full code
              _maybeSubmitCode();
            },
            decoration: const InputDecoration(
              border: InputBorder.none,
              counterText: '',
            ),
          ),
        );
      }),
    );
  }
}
