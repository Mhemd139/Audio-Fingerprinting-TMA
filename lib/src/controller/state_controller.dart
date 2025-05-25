import 'dart:async';
import 'dart:developer';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:get/get.dart';

import '../models/audio_model.dart';
import '../services/storage_services.dart';
import 'package:flutter_media_metadata/flutter_media_metadata.dart';

class StateController extends GetxController {
  List<AudioModel> audioList = [];
  List<AudioModel> favoriteAudioList = [];
  List<String> favoriteMusic = [];
  // late AudioModel currentPlay;
  StorageServices _storageServices = StorageServices();
  AssetsAudioPlayer assetsAudioPlayer = AssetsAudioPlayer();

  bool isPlaying = false;
  Duration selectedDuration = Duration(minutes: 10);
  bool isTimerRunning = false;

  getAudioFromStorage({int index = 0}) async {
    Metadata metadata;
    List<String> mp3Files = await _storageServices.getMP3Files();
    log('mp3Files :${mp3Files.length}');
    if (mp3Files.isEmpty) {
      audioList.add(
        AudioModel(
          name: 'Unknown',
          album: 'Unknown',
          path: 'Unknown',
        ),
      );
      // await setAudioPlayer(audioList);
    } else {
      mp3Files.forEach(
        (String filePath) async {
          // metadata = await MetadataRetriever.fromFile(File(filePath));
          audioList.add(
            AudioModel(
                name: filePath.split('/').last,
                album: 'Unknown', //metadata.albumName ?? 'Unknown',
                path: filePath,
                image: null // metadata.albumArt
                ),
          );
        },
      );
    }
    await setAudioPlayer(audioList);
    update();
  }

  Future setAudioPlayer(List<AudioModel> music) async {
    log(music.length.toString());
    // if (assetsAudioPlayer.playlist != null) {
    //   assetsAudioPlayer.playlist!.audios.clear();
    // await assetsAudioPlayer.dispose();

    // assetsAudioPlayer = AssetsAudioPlayer();
    // }
    await assetsAudioPlayer.open(
        Playlist(audios: [
          for (int i = 0; i < music.length; i++)
            Audio.file(
              music[i].path,
              metas: Metas(
                title: music[i].name,
                album: music[i].album,
                id: music[i].name + ' $i',
                artist: music[i].artist ?? 'Unknown',
                image: MetasImage.asset('assets/images/logo_app_music.png'),
              ),
            ),
        ]),
        loopMode: LoopMode.playlist,
        playInBackground: PlayInBackground.enabled,
        autoStart: false,
        showNotification: true,
        notificationSettings: NotificationSettings(
          stopEnabled: false,
        ));

    log('ready');
    update();
  }

  changePlayerStatus(bool state) {
    isPlaying = state;
    update();
  }

  AudioModel getCurrentAudioModel() {
    String currentMusicName = assetsAudioPlayer.getCurrentAudioTitle;
    AudioModel audioModel = AudioModel(name: '', album: '', path: '');
    if (audioList.isNotEmpty) {
      audioList.forEach((element) {
        if (currentMusicName == element.name) {
          audioModel = element;
        }
      });
    }
    return audioModel;
  }

  getFavorite() async {
    favoriteMusic = await _storageServices.getFavoriteMusic();
    for (var audioModel in audioList) {
      if (favoriteMusic.contains(audioModel.path)) {
        if (!favoriteAudioList.contains(audioModel)) {
          favoriteAudioList.add(audioModel);
        }
      }
    }
    update();
  }

  updateFavorite(AudioModel audioModel) async {
    if (audioModel.name != '') {
      if (favoriteAudioList.isEmpty) {
        getFavorite();
      }
      if (favoriteAudioList.contains(audioModel)) {
        favoriteAudioList.remove(audioModel);
        favoriteMusic.remove(audioModel.path);
      } else {
        favoriteAudioList.add(audioModel);
        favoriteMusic.add(audioModel.path);
      }
    }
    await _storageServices.saveFavoriteMusic(favoriteMusic);
    update();
  }

  runTimer({required Duration duration}) {
    Timer.periodic(
      duration,
      (timer) {
        if (isTimerRunning) {
          assetsAudioPlayer.pause();
          isTimerRunning = false;
          changePlayerStatus(false);
          // update();
        }
      },
    );
  }
}
