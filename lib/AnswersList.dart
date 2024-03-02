import 'package:flutter/cupertino.dart';
import 'package:quizzly/AnswerButton.dart';

class AnswersList extends ChangeNotifier {
  int activeId = 0;

  void setActive(int id){
    activeId = id;
    notifyListeners();
  }
}