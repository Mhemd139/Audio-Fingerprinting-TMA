import 'dart:developer';
import 'dart:io';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:path/path.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class StorageServices {
  late SharedPreferences _sharedPreferences;
  Future<List<String>> getMP3Files() async {
    List<String> mp3Files = [];
    try {
      var status = await Permission.storage.status;
      if (!status.isGranted) {
        await Permission.storage.request();
      } else {
        log('there is Permission');
      }
      List<String> directories = await OnAudioQuery().queryAllPath();

      for (var dir in directories) {
        final directory = Directory(dir);

        log(directory.path);

        List<FileSystemEntity> files = directory.listSync(recursive: true);

        for (var i = 0; i < files.length; i++) {
          if (extension(files[i].path) == ".mp3") {
            mp3Files.add(files[i].path);
          }
        }
      }
    } catch (e) {
      log('error in getMP3Files: $e');
    }
    return mp3Files;
  }

  static shareMusic(String path) {
    Share.shareXFiles([
      XFile(path),
    ]);
  }

  Future saveFavoriteMusic(List<String> favoriteMusic) async {
    await _sharedPreferences.setStringList('favoriteMusic', favoriteMusic);
  }

  Future<List<String>> getFavoriteMusic() async {
    List<String>? favorite;
    _sharedPreferences = await SharedPreferences.getInstance();

    if (_sharedPreferences.containsKey('favoriteMusic')) {
      favorite = _sharedPreferences.getStringList('favoriteMusic');
    } else {
      await saveFavoriteMusic([]);
    }
    return favorite ?? [];
  }
}
