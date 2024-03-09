import 'dart:ui' as ui;

import 'package:flutter/services.dart';

Future<ui.Image> loadImage(String imageAssetPath, Size? size) async {
  final ByteData data = await rootBundle.load(imageAssetPath);
  final codec = await ui.instantiateImageCodec(
    data.buffer.asUint8List(),
    targetHeight: (size == null) ? 0 : size.width.toInt()-30,
    targetWidth: (size == null) ? 0 : size.width.toInt()-30,
  );
  var frame = await codec.getNextFrame();
  return frame.image;
}