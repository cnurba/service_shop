import 'package:flutter/material.dart';
import 'package:service_shop/core/presentation/image/app_image_container.dart';
import 'package:service_shop/core/presentation/theme/colors.dart';

/// Buyer photo slider widget.
class CarouselSlider extends StatefulWidget {
  const CarouselSlider({
    super.key,
    required this.sliderHeight,
    required this.images,
    this.onTap,
  });

  /// The slider widget height.
  final double sliderHeight;

  /// The list of photos.
  final List<String> images;

  /// The event handler.
  final VoidCallback? onTap;

  @override
  _CarouselSliderState createState() => _CarouselSliderState();
}

class _CarouselSliderState extends State<CarouselSlider> {
  late PageController pageController;
  int selectedIndex = 0;

  @override
  void initState() {
    pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(
            height: widget.sliderHeight,
            child: PageView.builder(
              physics: const BouncingScrollPhysics(),
              controller: pageController,
              itemCount: widget.images.length,
              onPageChanged: (index) {
                setState(() {
                  selectedIndex = index;
                });
              },
              itemBuilder: (context, index) {
                final imageUrl = widget.images.elementAt(index);
                return AppImageContainer(
                  image: imageUrl,
                  width: double.infinity,
                  height: widget.sliderHeight,
                  fit: BoxFit.cover,
                );
              },
            ),
          ),
          const SizedBox(height: 5),
          SizedBox(
            height: 15,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: widget.images.length,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 100),
                  decoration: BoxDecoration(
                    color: index==selectedIndex?ServiceColors.primaryColor:Colors.grey,
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                  ),
                  margin: const EdgeInsets.all(5),
                  width: 15,
                  height: 10,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
