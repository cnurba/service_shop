import 'package:flutter/material.dart';
import 'package:service_shop/core/presentation/image/app_svg_image.dart';

class LoginAppbar extends StatelessWidget {
  const LoginAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset('assets/logo/logo_s.png', width: 65, height: 65),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppSvgImage(asset: AppSvgImage.logo, height: 35),
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Text(
                'Доставка до дома',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
