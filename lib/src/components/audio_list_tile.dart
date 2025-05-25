import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/audio_model.dart';
import '../res/app_style.dart';
import 'options_bottom_sheet.dart';

class AudioListTile extends StatelessWidget {
  const AudioListTile({super.key, required this.audioModel});
  final AudioModel audioModel;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: ListTile(
        contentPadding: const EdgeInsets.only(right: 10),
        leading: Container(
          height: 45,
          width: 45,
          decoration: BoxDecoration(
            color: AppStyle.appColors.accentColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            Icons.audiotrack,
            color: AppStyle.appColors.primaryColor, // Colors.black,
            size: 30,
          ),
        ),
        title: Text(
          audioModel.name,
          style: AppStyle.appTextStyles.normalStyle,
          maxLines: 1,
        ),
        subtitle: Text(
          audioModel.album,
          style: AppStyle.appTextStyles.hintStyle,
          maxLines: 1,
        ),
        trailing: IconButton(
          onPressed: () {
            Get.bottomSheet(OptionsBottomSheet(
              audioModel: audioModel,
            ));
          },
          icon: const Icon(
            Icons.more_vert,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
