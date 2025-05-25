import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/state_controller.dart';

class PlayerSlider extends StatelessWidget {
  const PlayerSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StateController>(builder: (stateController) {
      return stateController.assetsAudioPlayer.builderCurrent(
          builder: (context, play) {
        return SizedBox(
          width: Get.width,
          child: StreamBuilder(
              stream: stateController.assetsAudioPlayer.currentPosition,
              builder: (context, snapshot) {
                return Column(
                  children: [
                    Slider(
                      value: snapshot.data == null
                          ? 0
                          : snapshot.data!.inSeconds >
                                  play.audio.duration.inSeconds
                              ? play.audio.duration.inSeconds.toDouble()
                              : snapshot.data!.inSeconds.toDouble(),
                      max: play.audio.duration.inSeconds.toDouble(),
                      min: 0,
                      inactiveColor: Colors.grey[700],
                      onChanged: (value) {
                        Duration newDuration = Duration(seconds: value.toInt());
                        stateController.assetsAudioPlayer.seek(newDuration);
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          snapshot.data == null
                              ? '00:00'
                              : snapshot.data!.toString().split('.')[0],
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          play.audio.duration.toString().split('.')[0],
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              }),
        );
      });
    });
  }
}
