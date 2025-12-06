import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AppSvgImage extends StatelessWidget {
  const AppSvgImage({super.key, required this.asset, this.color, this.height, this.width});
  final String asset;
  final Color? color;
  final double? height;
  final double? width;

  static const String logo = 'assets/logo/logo.svg';


  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      asset,
      color: color,
      height: height,
      width: width,
    );
  }
}