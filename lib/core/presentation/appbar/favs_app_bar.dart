import 'package:flutter/material.dart';

class FavsAppBar extends StatelessWidget implements PreferredSizeWidget {
  const FavsAppBar({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(

          title: Text(
            title,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                  color: Colors.black,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        Container(
          height: 10,
          color: Colors.grey[300],

        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight+10);
}