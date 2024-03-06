import 'package:flutter/material.dart';

class QuestionDetails extends ChangeNotifier {
  int questionNumber = 1;

  void incrementQuestionNumber(){
    questionNumber++;
    notifyListeners();
  }

  void incrementQuestionNumberBy(int value){
    questionNumber += value;
    notifyListeners();
  }
}