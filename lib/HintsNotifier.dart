import 'dart:math';

import 'package:flutter/material.dart';

import 'Coord.dart';

class HintsNotifier extends ChangeNotifier {
  List<CoordBox> hintCoords = [];

  bool isRevealed = false;

  HintsNotifier(){
    Random _random = Random();
    double x = _random.nextInt(350-40).toDouble();
    double y = _random.nextInt(350-40).toDouble();
    hintCoords.add(CoordBox(x,y,40));
  }

  void addBox(CoordBox box){
    hintCoords.add(box);
    notifyListeners();
  }

  void reveal(){
    isRevealed = true;
    notifyListeners();
  }
}