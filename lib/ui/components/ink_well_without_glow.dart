import 'package:flutter/material.dart';

class InkWellWithoutGlow extends StatelessWidget {
  const InkWellWithoutGlow({required this.child, this.onTap, Key? key}) : super(key: key);

  final Widget child;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.transparent,
      overlayColor: MaterialStateProperty.all(Colors.transparent),
      onTap: onTap,
      child: child,
    );
  }
}
