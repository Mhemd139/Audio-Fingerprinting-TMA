import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tma/src/controller/state_controller.dart';

import '../models/audio_model.dart';
import '../services/storage_services.dart';
import 'option_icon_button.dart';

class PauseViewer extends StatelessWidget {
  PauseViewer({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StateController>(builder: (stateController) {
      AudioModel audioModel = stateController.getCurrentAudioModel();
      return Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          OptionIconButton(
            icon: stateController.favoriteMusic.contains(audioModel.path)
                ? Icons.favorite
                : Icons.favorite_outline,
            onPressed: () {
              stateController.updateFavorite(audioModel);
            },
          ),
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: const Color.fromRGBO(174, 30, 205, 0.75),
                width: 3,
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: const Color.fromRGBO(246, 38, 125, 0.7),
                  width: 2,
                ),
              ),
              child: IconButton(
                onPressed: () async {
                  stateController.changePlayerStatus(true);
                  await stateController.assetsAudioPlayer.play();
                },
                icon: const Icon(
                  Icons.play_arrow,
                  size: 80,
                ),
              ),
            ),
          ),
          OptionIconButton(
            icon: Icons.share,
            onPressed: () {
              StorageServices.shareMusic(audioModel.path);
            },
          ),
        ],
      );
    });
  }
}
