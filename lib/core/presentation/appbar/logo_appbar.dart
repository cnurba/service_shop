import 'package:flutter/material.dart';
import 'package:service_shop/core/presentation/image/app_svg_image.dart';
import 'package:service_shop/core/presentation/theme/colors.dart';

class LogoAppbar extends StatelessWidget implements PreferredSizeWidget {
  const LogoAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ServiceColors.primaryColor,
      height: kToolbarHeight + 10,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/logo/logo_s.png', width: 40, height: 40),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppSvgImage(
                asset: AppSvgImage.logo,
                height: 25,

                // width: double.infinity,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Text(
                  'Доставка до дома',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 10);
}
