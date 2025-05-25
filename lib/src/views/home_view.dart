import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tma/src/components/player_bottom_sheet.dart';

import '../components/audio_list_tile.dart';
import '../controller/state_controller.dart';

class HomeView extends GetView<StateController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Scaffold(
          appBar: AppBar(
            title: Text('Local Music'),
          ),
          body: ListView.builder(
            padding: EdgeInsets.only(bottom: 200),
            itemCount: controller.audioList.length,
            itemBuilder: (context, index) => InkWell(
              onTap: () async {
                controller.changePlayerStatus(true);
                await controller.assetsAudioPlayer.playlistPlayAtIndex(index);
                controller.update();
              },
              child: AudioListTile(
                audioModel: controller.audioList[index],
              ),
            ),
          ),
          extendBody: true,
        ),
        PlayerBottomSheet(),
      ],
    );
  }
}
