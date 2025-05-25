import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tma/src/controller/state_controller.dart';
import 'package:tma/src/res/app_style.dart';

import '../components/audio_list_tile.dart';
import '../components/player_bottom_sheet.dart';

class FavoriteView extends StatelessWidget {
  FavoriteView({super.key});
  bool _isPlayFavorite = false;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<StateController>(builder: (stateController) {
      if (stateController.favoriteAudioList.isEmpty) {
        stateController.getFavorite();
      }

      return Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Scaffold(
            appBar: AppBar(
              title: Text('Favorite'),
            ),
            body: stateController.favoriteAudioList.isEmpty
                ? Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 100,
                      ),
                      Image.asset(
                        'assets/images/folder_open.png',
                        height: 100,
                      ),
                      Text(
                        'Favorites',
                        style: AppStyle.appTextStyles.titleStyle,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 50),
                        child: Text(
                          'come on! We have great music :)',
                          textAlign: TextAlign.center,
                          style: AppStyle.appTextStyles.hintStyle,
                        ),
                      ),
                    ],
                  )
                : ListView.builder(
                    padding: EdgeInsets.only(bottom: 200),
                    itemCount: stateController.favoriteAudioList.length,
                    itemBuilder: (context, index) => InkWell(
                      onTap: () async {
                        if (!_isPlayFavorite) {
                          await stateController.setAudioPlayer(
                              stateController.favoriteAudioList);
                        }
                        stateController.changePlayerStatus(true);
                        await stateController.assetsAudioPlayer
                            .playlistPlayAtIndex(index);
                        stateController.update();
                      },
                      child: AudioListTile(
                        audioModel: stateController.favoriteAudioList[index],
                      ),
                    ),
                  ),
          ),
          PlayerBottomSheet(),
        ],
      );
    });
  }
}
