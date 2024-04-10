import 'package:flutter/cupertino.dart';

import 'coord_box.dart';

class OngoingQuizAQState extends ChangeNotifier{
  final List<CoordBox> hints;
  int _loadHintsUntilExklIndex = 1;

  bool _isRevealed = false;

  OngoingQuizAQState({required this.hints});

  bool isRevealed(){
    return _isRevealed;
  }

  void reveal(){
    _isRevealed = true;
    notifyListeners();
  }

  void hide(){
    _isRevealed = false;
    notifyListeners();
  }

  void loadNextHint(){
    if(_loadHintsUntilExklIndex < hints.length){
      _loadHintsUntilExklIndex++;
      notifyListeners();
    }
  }

  void popLatestHint(){
    if(_loadHintsUntilExklIndex > 1){
      _loadHintsUntilExklIndex--;
      notifyListeners();
    }
  }

  List<CoordBox> getLoadedHints(){
    return hints.getRange(0, _loadHintsUntilExklIndex).toList();
  }

  int getRevealedHintAmount(){
    return _loadHintsUntilExklIndex-1;
  }
}