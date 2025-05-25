import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/state_controller.dart';
import 'option_icon_button.dart';

class PlayViewer extends StatelessWidget {
  PlayViewer({
    super.key,
    this.onPlay,
  });
  void Function()? onPlay;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<StateController>(builder: (stateController) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          OptionIconButton(
            icon: Icons.replay,
            onPressed: () {},
          ),
          OptionIconButton(
            icon: Icons.skip_previous,
            onPressed: () async {
              await stateController.assetsAudioPlayer.previous();
              stateController.update();
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
                  stateController.changePlayerStatus(false);
                  await stateController.assetsAudioPlayer.pause();
                },
                icon: const Icon(
                  Icons.pause,
                  size: 50,
                ),
              ),
            ),
          ),
          OptionIconButton(
            icon: Icons.skip_next,
            onPressed: () async {
              await stateController.assetsAudioPlayer.next();
              stateController.update();
            },
          ),
          OptionIconButton(
            icon: Icons.repeat_rounded,
            onPressed: () {
              log(stateController.assetsAudioPlayer.playlist!.audios.length
                  .toString());
            },
          ),
        ],
      );
    });
  }
}
