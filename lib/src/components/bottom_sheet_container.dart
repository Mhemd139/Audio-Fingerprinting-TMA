import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../res/app_style.dart';

class BottomSheetContainer extends StatelessWidget {
  const BottomSheetContainer({
    super.key,
    required this.child,
    this.height = 220,
  });
  final Widget child;
  final double? height;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      height: height,
      width: Get.width,
      decoration: BoxDecoration(
        color: AppStyle.appColors.secondaryColor,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(25),
        ),
      ),
      child: child,
    );
  }
}
