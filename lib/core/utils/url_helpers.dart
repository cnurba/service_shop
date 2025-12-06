import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';

Future<void> openWhatsApp(String phone, String message) async {
  final encodedMessage = Uri.encodeComponent(message);
  final uri = Uri.parse('https://wa.me/$phone?text=$encodedMessage');

  if (await canLaunchUrl(uri)) {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  } else {
    debugPrint('Could not launch WhatsApp: $uri');
  }
}

Future<void> openInstagram(String username) async {
  final uri = Uri.parse('https://instagram.com/$username');

  if (await canLaunchUrl(uri)) {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  } else {
    debugPrint('Could not launch Instagram: $uri');
  }
}
