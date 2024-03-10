import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:quizzly/utils.dart';

import 'Coord.dart';
import 'Episodes.dart';
import 'QuestionDetails.dart';

class CurrentQuizState extends ChangeNotifier {
  int totalPoints = 0;
  int localPoints = 20;

  List<QuestionDetails> _questionHistory = [];

  final Random _random = Random();

  late List<String> _leftTitles;

  CurrentQuizState(){
    _leftTitles = Episodes.episodeTitles.getRange(0, 201).toList();
    createNewQuestion();
  }

  CurrentQuizState.initializeWith(QuestionDetails initialQuestion){
    _leftTitles = Episodes.episodeTitles.getRange(0, 201).toList();
    _leftTitles.remove(initialQuestion.getCorrectAnswerTitle());
    _questionHistory.add(initialQuestion);
  }

  void setLocalMinus(int value){
    localPoints -= value;
    notifyListeners();
  }

  void setTotalPlusLocal(){
    totalPoints += localPoints;
    localPoints = 20;
    notifyListeners();
  }

  QuestionDetails getLatestQuestionDetails(){
    return _questionHistory.last;
  }

  QuestionDetails createNewQuestion(){
    List<String> possibleAnswers = [];
    List<String> titlesForSelection = [..._leftTitles];

    int randomIdx;
    for(int i=0; i<6; i++){
      randomIdx = _random.nextInt(_leftTitles.length-1-i);
      possibleAnswers.add(titlesForSelection[randomIdx]);
      titlesForSelection.removeAt(randomIdx);
    }

    int correctAnswer = _random.nextInt(5);
    _leftTitles.remove(possibleAnswers[correctAnswer]);

    QuestionDetails newQuestion = QuestionDetails(
      answerStack: possibleAnswers,
      correctAnswerId: correctAnswer,
      questionNumber: _questionHistory.length+1,
      coverAssetPath: generateEpCoverAssetPath(possibleAnswers[correctAnswer])
    );

    _questionHistory.add(newQuestion);

    notifyListeners();
    return newQuestion;
  }

  static QuestionDetails createInitialQuestion(){
    List<String> titles = Episodes.episodeTitles.getRange(0, 201).toList();

    List<String> possibleAnswers = [];
    Random random = Random();
    int randomIdx;
    for(int i=0; i<6; i++){
      randomIdx = random.nextInt(titles.length-1-i);
      possibleAnswers.add(titles[randomIdx]);
    }

    int correctAnswer = random.nextInt(5);

    QuestionDetails initialQuestion = QuestionDetails(
        answerStack: possibleAnswers,
        correctAnswerId: correctAnswer,
        questionNumber: 1,
        coverAssetPath: generateEpCoverAssetPath(possibleAnswers[correctAnswer])
    );

    return initialQuestion;
  }

  void completeCurrentQuestion(List<CoordBox> hints, ){

  }

  void setCurrentQuestionAnswerState(QuestionAnswerState state){
    _questionHistory.last.questionAnswerState = state;
  }

  int getNumberOfQuestions(){
    return _questionHistory.length;
  }
}