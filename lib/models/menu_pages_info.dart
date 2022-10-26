import 'package:flutter/cupertino.dart';

class MenuPageInfo {
  MenuPageInfo({
    required this.name,
    required this.title,
    required this.icon,
    required this.activeIcon,
    required this.page,
    this.isActive = false,
  });

  final String name;
  final String title;
  final Widget icon;
  final Widget page;
  final Widget activeIcon;
  bool isActive;

  Widget get currentIcon => isActive ? activeIcon : icon;
}
