import 'package:flutter/cupertino.dart';
import 'package:quizzly/AnswerButton.dart';

class CurrentPoints extends ChangeNotifier {
  int total = 0;
  int local = 20;

  void setLocal(int value){
    local = value;
    notifyListeners();
  }
}