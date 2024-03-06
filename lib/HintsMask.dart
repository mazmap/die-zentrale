import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';

import "dart:ui" as ui;

import 'package:flutter/services.dart';

class HintsMask extends CustomPainter {
  final ui.Image image;

  HintsMask(this.image);

  @override
  void paint(Canvas canvas, Size size) async {
    Paint paint = Paint();
    paint.color = Colors.white;
    paint.style = PaintingStyle.fill;

    canvas.drawImage(image, const Offset(0, 0), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}