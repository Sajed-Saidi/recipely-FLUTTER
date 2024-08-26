import 'package:flutter/material.dart';

class MyIconButton extends StatelessWidget {
  final Icon icon;
  final Color iconColor;
  final Color iconBGColor;
  final VoidCallback onPressed;

  static void _defaultFunction() {}
  const MyIconButton(
      {super.key,
      required this.icon,
      required this.iconColor,
      required this.iconBGColor,
      this.onPressed = _defaultFunction});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: iconBGColor,
      ),
      child: IconButton(
        icon: icon,
        color: iconColor,
        onPressed: onPressed,
      ),
    );
  }
}
