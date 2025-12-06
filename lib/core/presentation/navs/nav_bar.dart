import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavBar extends CupertinoTabBar {
  /// NavBar для страниц из [CupertinoTabView] на [HomeScreen]
  NavBar({super.key, required ValueChanged<int> onTab})
    : super(
        onTap: onTab,
        items: [
          const BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.home),
            label: "Магазин",
          ),
          const BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.search),
            label: "Поиск",
          ),

          const BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.heart_fill),
            label: "Избранное",
          ),

          const BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.cart_fill),
            label: "Корзина",
          ),

          const BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Профиль",
          ),
        ],
        border: const Border(
          top: BorderSide(color: Colors.black38, width: 0.7),
        ),
        backgroundColor: Colors.white,
      );
}
