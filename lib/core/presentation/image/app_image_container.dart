import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:service_shop/core/http/server_address.dart';

/// Create image container with border radius and box shadow.
/// user [cached_network_image] package.
/// if image is null or empty, show placeholder image.
/// user image ServerAddress().imageUrl as base url.
class AppImageContainer extends StatelessWidget {
  const AppImageContainer({
    super.key,
    required this.image,
    this.width = 100,
    this.height = 100,
    this.borderRadius = 8.0,
    this.boxShadow = const [
      BoxShadow(color: Colors.black12, blurRadius: 4.0, offset: Offset(0, 2)),
    ],
    this.fit = BoxFit.contain,
    this.placeholder,
    this.errorWidget,
  });

  final String? image;
  final double width;
  final double height;
  final double borderRadius;
  final List<BoxShadow> boxShadow;
  final BoxFit fit;
  final Widget? placeholder;
  final Widget? errorWidget;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: boxShadow,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: image == null || image!.isEmpty
            ? placeholder ??
                  Image.asset('assets/logo/placeholder.png', fit: fit)
            : CachedNetworkImage(
                imageUrl: "${ServerAddress().imageUrl}$image",
                fit: fit,
                placeholder: (context, url) =>
                    placeholder ?? Center(child: SizedBox.shrink()),
                errorWidget: (context, url, error) =>
                    errorWidget ?? Icon(Icons.error, color: Colors.red),
              ),
      ),
    );
  }
}
