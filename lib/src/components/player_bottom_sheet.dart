import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tma/src/components/option_icon_button.dart';

import '../controller/state_controller.dart';
import '../models/audio_model.dart';
import '../res/app_style.dart';
import 'bottom_sheet_container.dart';

class PlayerBottomSheet extends StatelessWidget {
  const PlayerBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StateController>(builder: (stateController) {
      AudioModel audioModel = stateController.getCurrentAudioModel();
      return stateController.assetsAudioPlayer.builderCurrent(
          builder: (context, play) {
        return StreamBuilder(
            stream: stateController.assetsAudioPlayer.currentPosition,
            builder: (context, snapshot) {
              return Container(
                color: Colors.transparent,
                height: 200,
                child: Scaffold(
                  backgroundColor: Colors.transparent,
                  body: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Positioned(
                        top: 0,
                        child: GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: Container(
                            padding: const EdgeInsets.only(top: 15),
                            alignment: Alignment.topCenter,
                            height: 150,
                            width: 150,
                            decoration: BoxDecoration(
                              color: AppStyle.appColors.secondaryColor,
                              shape: BoxShape.circle,
                            ),
                            child: Hero(
                              tag: 'tag1',
                              child: Container(
                                height: 3,
                                width: 30,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        child: BottomSheetContainer(
                          height: 180,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      stateController
                                          .updateFavorite(audioModel);
                                    },
                                    child: Icon(
                                      stateController.favoriteMusic
                                              .contains(audioModel.path)
                                          ? Icons.favorite
                                          : Icons.favorite_outline,
                                      size: 30,
                                    ),
                                  ),
                                  const Spacer(flex: 2),
                                  SizedBox(
                                    width: Get.width * 0.75,
                                    height: 30,
                                    child: AutoSizeText(
                                      stateController.assetsAudioPlayer
                                          .getCurrentAudioTitle,
                                      style: AppStyle.appTextStyles.normalStyle,
                                      maxLines: 2,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  const Spacer(flex: 3),
                                ],
                              ),
                              Slider(
                                value: snapshot.data == null
                                    ? 0
                                    : snapshot.data!.inSeconds.toDouble(),
                                max: play.audio.duration.inSeconds.toDouble(),
                                min: 0,
                                inactiveColor: Colors.grey[700],
                                onChanged: (value) {
                                  Duration newDuration =
                                      Duration(seconds: value.toInt());
                                  stateController.assetsAudioPlayer
                                      .seek(newDuration);
                                },
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  OptionIconButton(
                                    icon: Icons.skip_previous,
                                    onPressed: () async {
                                      await stateController.assetsAudioPlayer
                                          .previous();
                                      stateController.update();
                                    },
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: const Color.fromRGBO(
                                            174, 30, 205, 0.75),
                                        width: 3,
                                      ),
                                    ),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: const Color.fromRGBO(
                                              246, 38, 125, 0.7),
                                          width: 2,
                                        ),
                                      ),
                                      child: IconButton(
                                        onPressed: () async {
                                          await stateController
                                              .assetsAudioPlayer
                                              .playOrPause();
                                          stateController.update();
                                          stateController.changePlayerStatus(
                                              stateController.assetsAudioPlayer
                                                  .isPlaying.value);
                                        },
                                        icon: Icon(
                                          stateController.assetsAudioPlayer
                                                  .isPlaying.value
                                              ? Icons.pause
                                              : Icons.play_arrow,
                                          size: 35,
                                        ),
                                      ),
                                    ),
                                  ),
                                  OptionIconButton(
                                    icon: Icons.skip_next,
                                    onPressed: () async {
                                      await stateController.assetsAudioPlayer
                                          .next();
                                      stateController.update();
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            });
      });
    });
  }
}
