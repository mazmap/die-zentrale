import 'dart:math';

import 'package:flutter/material.dart';

import 'coord_box.dart';

class HintsNotifier extends ChangeNotifier {
  List<CoordBox> hintCoords = [];

  HintsNotifier(){
    Random random = Random();
    double x = random.nextInt(350-40).toDouble();
    double y = random.nextInt(350-40).toDouble();
    hintCoords.add(CoordBox(x,y,40));
  }

  void addBox(CoordBox box){
    hintCoords.add(box);
    notifyListeners();
  }

  void reset(){
    hintCoords = [];
    Random random = Random();
    double x = random.nextInt(350-40).toDouble();
    double y = random.nextInt(350-40).toDouble();
    hintCoords.add(CoordBox(x,y,40));

    notifyListeners();
  }
}