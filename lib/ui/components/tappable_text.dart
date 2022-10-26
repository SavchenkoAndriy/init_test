import 'package:flutter/material.dart';

import 'ink_well_without_glow.dart';

class TappableText extends StatelessWidget {
  const TappableText({
    required this.text,
    required this.color,
    required this.horizontalPadding,
    required this.fontSize,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  final String text;
  final Color color;
  final double horizontalPadding;
  final double fontSize;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWellWithoutGlow(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
        child: Text(text, style: TextStyle(color: color, fontSize: fontSize)),
      ),
    );
  }
}
