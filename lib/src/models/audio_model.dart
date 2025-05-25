import 'package:flutter/services.dart';

class AudioModel {
  final String name;
  final String album;
  final String path;
  final String? artist;
  final Uint8List? image;

  AudioModel({
    required this.name,
    required this.album,
    required this.path,
    this.image,
    this.artist,
  });
}
