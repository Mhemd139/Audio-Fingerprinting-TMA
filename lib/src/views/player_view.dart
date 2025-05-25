import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tma/src/models/audio_model.dart';
import 'package:tma/src/res/app_style.dart';

import '../components/options_bottom_sheet.dart';
import '../components/pause_viewer.dart';
import '../components/play_viewer.dart';
import '../components/player_slider.dart';
import '../components/stacked_icons.dart';
import '../components/timer_bottom_sheet.dart';
import '../controller/state_controller.dart';
import 'favorite_view.dart';
import 'home_view.dart';

class PlayerView extends StatefulWidget {
  const PlayerView({super.key});

  @override
  State<PlayerView> createState() => _PlayerViewState();
}

class _PlayerViewState extends State<PlayerView> {
  StateController stateController = Get.put(StateController(), permanent: true);

  bool _isNavigateToHome = true;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<StateController>(builder: (stateController) {
      AudioModel audioModel = stateController.getCurrentAudioModel();
      return Scaffold(
        appBar: AppBar(
          leadingWidth: 100,
          leading: Row(
            children: [
              const SizedBox(
                width: 10,
              ),
              InkWell(
                onTap: () {
                  _isNavigateToHome = false;
                  Get.to(() => FavoriteView());
                },
                child: const StackedIcons(
                  iconData: Icons.favorite_outline,
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              InkWell(
                onTap: () {
                  _isNavigateToHome = true;
                  Get.to(() => const HomeView());
                },
                child: const StackedIcons(
                  iconData: Icons.circle_outlined,
                ),
              ),
            ],
          ),
          actions: [
            IconButton(
              onPressed: () async {
                Get.bottomSheet(TimerBottomSheet());
              },
              icon: const Icon(Icons.add_alarm),
            ),
            IconButton(
              onPressed: () {
                Get.bottomSheet(
                  OptionsBottomSheet(
                    audioModel: audioModel,
                  ),
                );
              },
              icon: const Icon(Icons.more_vert),
            ),
          ],
        ),
        body: SizedBox(
          height: Get.height,
          width: Get.width,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Positioned(
                top: 0,
                child: GestureDetector(
                  onTap: () {
                    if (_isNavigateToHome) {
                      Get.to(() => const HomeView());
                    } else {
                      Get.to(() => FavoriteView());
                    }
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
              stateController.assetsAudioPlayer.builderCurrent(
                  builder: (context, play) {
                AudioModel audioModel = stateController.getCurrentAudioModel();
                return Container(
                  padding: const EdgeInsets.all(30),
                  margin: EdgeInsets.only(top: 25),
                  height: Get.height,
                  width: Get.width,
                  decoration: BoxDecoration(
                    color: AppStyle.appColors.secondaryColor,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(25),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: Get.width,
                        height: 270,
                        decoration: BoxDecoration(
                          color: AppStyle.appColors.primaryColor,
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                            image: audioModel.image != null
                                ? MemoryImage(
                                    audioModel.image!,
                                  )
                                : AssetImage('assets/images/logo_app_music.png')
                                    as ImageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                        // child:
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            IconButton(
                              onPressed: () {
                                stateController.updateFavorite(audioModel);
                              },
                              icon: Icon(
                                stateController.favoriteMusic
                                        .contains(audioModel.path)
                                    ? Icons.favorite
                                    : Icons.favorite_outline,
                                size: 35,
                              ),
                            ),
                            const Spacer(flex: 2),
                            SizedBox(
                              width: Get.width * 0.6,
                              child: Column(
                                children: [
                                  AutoSizeText(
                                    audioModel.name,
                                    style: AppStyle.appTextStyles.normalStyle,
                                    maxLines: 2,
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  AutoSizeText(
                                    audioModel.album,
                                    style: AppStyle.appTextStyles.hintStyle,
                                    maxLines: 2,
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                            const Spacer(flex: 5),
                          ],
                        ),
                      ),
                      Visibility(
                        visible: stateController.isPlaying,
                        child: PlayerSlider(),
                      ),
                      const Spacer(flex: 2),
                      Visibility(
                        visible: stateController.isPlaying,
                        replacement: PauseViewer(),
                        child: PlayViewer(),
                      ),
                      const Spacer(flex: 1),
                    ],
                  ),
                );
              }),
            ],
          ),
        ),
      );
    });
  }
}
