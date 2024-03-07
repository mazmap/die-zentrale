import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';

import "dart:ui" as ui;

import 'package:flutter/services.dart';

import 'Coord.dart';

class HintsMask extends CustomPainter {
  final ui.Image image;
  final List<CoordBox> hintCoords;
  final bool reveal;

  HintsMask(this.image, this.hintCoords, this.reveal);

  @override
  void paint(Canvas canvas, Size size) async {
    Paint paint = Paint();
    paint.color = Colors.white;
    paint.style = PaintingStyle.fill;

    if(!reveal){
      final path = Path();

      for(CoordBox coord in hintCoords){
        path.addRect(Rect.fromLTWH(coord.x, coord.y, coord.h, coord.h));
      }

      canvas.clipPath(path);
    }

    canvas.drawImage(image, const Offset(0, 0), paint);

    Paint borderPaint = Paint();
    borderPaint.style = PaintingStyle.stroke;
    borderPaint.strokeWidth = 1.0;
    borderPaint.color = Colors.white;

    canvas.drawRect(
        Rect.fromLTWH(hintCoords.last.x+1, hintCoords.last.y+1, hintCoords.last.h-2, hintCoords.last.h-2),
        borderPaint
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}