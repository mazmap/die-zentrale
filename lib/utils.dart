import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import 'Episodes.dart';
import 'EpisodesService.dart';

Future<ui.Image> loadImage(String imageAssetPath, Size? size) async {
  final ByteData data = await rootBundle.load(imageAssetPath);

  final codec = await ui.instantiateImageCodec(
    data.buffer.asUint8List(),
    allowUpscaling: false
  );
  var frame = await codec.getNextFrame();
  return frame.image;
}

/*
String generateEpCoverAssetPath(String episodeName) {
  int episodeNumber = Episodes.episodes.indexOf(episodeName)+1;
  String stringifiedEpNumber = "00$episodeNumber";
  stringifiedEpNumber = stringifiedEpNumber.substring(stringifiedEpNumber.length-3, stringifiedEpNumber.length);
  return "assets/illustrations/illustration-folge-$stringifiedEpNumber.png";
}
*/