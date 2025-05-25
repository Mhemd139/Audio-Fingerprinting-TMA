import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tma/src/views/player_view.dart';

import '../res/app_style.dart';

class MusicCheckerView extends StatelessWidget {
  const MusicCheckerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyle.appColors.secondaryColor,
      appBar: AppBar(
        backgroundColor: AppStyle.appColors.secondaryColor,
        leading: IconButton(
          onPressed: () {
            Get.off(() => PlayerView());
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: InkWell(
        onTap: () {
          ///
        },
        child: Center(
          child: Image.asset('assets/images/logo_app_music.png'),
        ),
      ),
    );
  }
}
