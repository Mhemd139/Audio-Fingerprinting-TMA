import 'package:flutter/material.dart';

import '../res/app_style.dart';

class StackedIcons extends StatelessWidget {
  const StackedIcons({super.key, required this.iconData});
  final IconData iconData;
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        const Icon(
          Icons.menu,
          size: 27,
        ),
        Container(
          color: AppStyle.appColors.primaryColor,
          child: Icon(
            iconData,
            size: 12,
          ),
        ),
      ],
    );
  }
}
