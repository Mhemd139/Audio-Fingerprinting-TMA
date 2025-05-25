import 'package:flutter/material.dart';

import '../res/app_style.dart';

class OptionListTile extends StatelessWidget {
  OptionListTile({
    super.key,
    required this.title,
    required this.iconData,
    this.onTap,
  });
  final String title;
  final IconData iconData;
  Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Icon(
        iconData,
        color: Colors.white,
      ),
      title: Text(
        title,
        style: AppStyle.appTextStyles.boldStyle,
      ),
    );
  }
}
