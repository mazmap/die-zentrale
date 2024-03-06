import 'package:flutter/cupertino.dart';
import 'package:quizzly/AnswerButton.dart';

class CurrentPoints extends ChangeNotifier {
  int total = 0;
  int local = 20;

  void setLocalMinus(int value){
    local -= value;
    notifyListeners();
  }

  void setTotalPlusLocal(){
    total += local;
    local = 20;
    notifyListeners();
  }
}