import 'package:flutter/material.dart';
import 'package:service_shop/core/presentation/theme/colors.dart';

class FaqExpansionTile extends StatelessWidget {
  final String question;
  final String answer;
  final List<String>? boldText; // List of words/phrases to bold

  const FaqExpansionTile({
    super.key,
    required this.question,
    required this.answer,
    this.boldText,
  });

  @override
  Widget build(BuildContext context) {
    // If no bold words, just display normal text
    Widget child;
    if (boldText == null || boldText!.isEmpty) {
      child = Text(answer);
    } else {
      // Build RichText with multiple bold words
      List<TextSpan> spans = [];
      String remainingText = answer;

      for (var bold in boldText!) {
        if (!remainingText.contains(bold)) continue;
        final parts = remainingText.split(bold);
        spans.add(TextSpan(text: parts[0])); // normal text
        spans.add(
          TextSpan(
            text: bold,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        );
        remainingText = parts.sublist(1).join(bold); // remainder text
      }
      spans.add(TextSpan(text: remainingText)); // add remaining text

      child = RichText(
        text: TextSpan(
          style: const TextStyle(fontSize: 12, color: Colors.black, height: 0),
          children: spans,
        ),
      );
    }

    // Build the actual tile
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          childrenPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          // iconColor: Colors.blue,
          collapsedIconColor: Colors.grey,
          title: Text(
            question,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: ServiceColors.grey,
            ),
          ),
          children: [child],
        ),
      ),
    );
  }
}
