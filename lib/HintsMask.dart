import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';

import "dart:ui" as ui;

import 'package:flutter/services.dart';

import 'Coord.dart';

class HintsMask extends CustomPainter {
  final ui.Image image;
  final List<CoordBox> hintCoords;

  HintsMask(this.image, this.hintCoords);

  @override
  void paint(Canvas canvas, Size size) async {
    Paint paint = Paint();
    paint.color = Colors.white;
    paint.style = PaintingStyle.fill;

    final path = Path();

    for(CoordBox coord in hintCoords){
      path.addRect(Rect.fromLTWH(coord.x, coord.y, 50, 50));
    }

    canvas.clipPath(path);

    canvas.drawImage(image, const Offset(0, 0), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}