import 'package:flutter/material.dart';

class NumericKeyboard extends StatelessWidget {
  final Function(String) onNumberPressed;
  final VoidCallback onBackspace;

  const NumericKeyboard({
    super.key,
    required this.onNumberPressed,
    required this.onBackspace,
  });

  @override
  Widget build(BuildContext context) {
    final buttons = [
      '1',
      '2',
      '3',
      '4',
      '5',
      '6',
      '7',
      '8',
      '9',
      '',
      '0',
      'back',
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: buttons.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 8, // smaller spacing
        crossAxisSpacing: 8, // smaller spacing
        childAspectRatio: 1.7, // square buttons
      ),
      itemBuilder: (context, index) {
        final value = buttons[index];
        if (value == '') return const SizedBox(); // empty cell
        Widget buttonChild;

        if (value == 'back') {
          buttonChild = const Icon(Icons.backspace_outlined, size: 20);
        } else {
          buttonChild = Text(
            value,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ), // smaller font
          );
        }

        return SizedBox(
          child: ElevatedButton(
            onPressed: value == 'back'
                ? onBackspace
                : () => onNumberPressed(value),
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.zero,
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6), // smaller radius
              ),
              elevation: 2,
            ),
            child: buttonChild,
          ),
        );
      },
    );
  }
}
