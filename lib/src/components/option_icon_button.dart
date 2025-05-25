import 'package:flutter/material.dart';

class OptionIconButton extends StatelessWidget {
  OptionIconButton({super.key, required this.icon, this.onPressed});
  final IconData icon;
  void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.3),
        shape: BoxShape.circle,
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(icon),
        iconSize: 30,
      ),
    );
  }
}
