import 'package:flutter/cupertino.dart';

class AnswersList extends ChangeNotifier {
  int _activeId = -1;
  int _correctAnswerId;

  AnswersList(this._correctAnswerId);

  void setActive(int id){
    _activeId = id;
    notifyListeners();
  }

  int resetAndUpdateWith(int newCorrectAnswerId){
    int activeId = _activeId;
    reset();
    _correctAnswerId = newCorrectAnswerId;
    notifyListeners();
    return activeId;
  }

  void reset(){
    _activeId = -1;
  }

  bool isOneSelected(){
    return _activeId != -1;
  }

  bool isCorrectAnswerSelected(){
    return _activeId == _correctAnswerId;
  }

  bool isCorrectAnswer(int id){
    return id == _correctAnswerId;
  }

  bool isActiveId(int id){
    return id == _activeId;
  }
}