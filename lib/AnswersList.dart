import 'package:flutter/cupertino.dart';
import 'package:quizzly/AnswerButton.dart';

class AnswersList extends ChangeNotifier {
  int _activeId = -1;
  final int _correctAnswerId;
  bool _isRevealed = false;

  AnswersList(this._correctAnswerId);

  void setActive(int id){
    _activeId = id;
    notifyListeners();
  }

  void reveal(){
    _isRevealed = true;
    notifyListeners();
  }

  bool isRevealed(){
    return _isRevealed;
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