import 'dart:math';

import 'package:flutter/cupertino.dart';

import 'coord_box.dart';
import 'episode.dart';
import 'episodes.dart';
import 'episodes_service.dart';
import 'question_details.dart';

class CurrentQuizState extends ChangeNotifier {
  final List<QuestionDetails> _questionHistory = [];

  final Random _random = Random();

  late List<Episode> _leftTitles;

  CurrentQuizState(){
    _leftTitles = Episodes.episodes.getRange(0, 201).toList();
    createNewQuestion();
  }

  CurrentQuizState.initializeWith(QuestionDetails initialQuestion){
    _leftTitles = [...Episodes.episodes];
    _leftTitles.remove(initialQuestion.getCorrectAnswerEpisode());
    _questionHistory.add(initialQuestion);
  }

  void setCurrentQuestionPossiblePointsMinus(int value){
    _questionHistory.last.possiblePoints -= value;
    notifyListeners();
  }

  int getCurrentlyPossiblePoints(){
    return _questionHistory.last.possiblePoints;
  }

  int getTotalPoints(){
    int totalPoints = 0;

    QuestionDetails element;
    for(int i=0; i<_questionHistory.length; i++){
      element = _questionHistory[i];
      if(element.answerState == AnswerState.rightAnswer){
        totalPoints += element.possiblePoints;
      }
    }

    return totalPoints;
  }

  QuestionDetails getLatestQuestionDetails(){
    return _questionHistory.last;
  }

  QuestionDetails createNewQuestion(){
    List<Episode> possibleAnswers = [];
    List<Episode> titlesForSelection = [..._leftTitles];

    int randomIdx;
    for(int i=0; i<6; i++){
      randomIdx = _random.nextInt(_leftTitles.length-1-i);
      possibleAnswers.add(titlesForSelection[randomIdx]);
      titlesForSelection.removeAt(randomIdx);
    }

    int correctAnswer = _random.nextInt(6);
    _leftTitles.remove(possibleAnswers[correctAnswer]);

    QuestionDetails newQuestion = QuestionDetails(
      answerStack: possibleAnswers,
      correctAnswerId: correctAnswer,
      questionNumber: _questionHistory.length+1,
      coverAssetPath: possibleAnswers[correctAnswer].coverAssetPath
    );

    _questionHistory.add(newQuestion);

    notifyListeners();
    return newQuestion;
  }

  static QuestionDetails createInitialQuestion(){
    List<Episode> possibleAnswers = [];
    Random random = Random();
    int randomIdx;
    for(int i=0; i<6; i++){
      randomIdx = random.nextInt(EpisodesService.getEpisodesAmount()-1-i);
      possibleAnswers.add(EpisodesService.getNthEpisode(randomIdx));
    }

    int correctAnswer = random.nextInt(6);

    QuestionDetails initialQuestion = QuestionDetails(
        answerStack: possibleAnswers,
        correctAnswerId: correctAnswer,
        questionNumber: 1,
        coverAssetPath: possibleAnswers[correctAnswer].coverAssetPath
    );

    return initialQuestion;
  }

  void completeCurrentQuestion(AnswerState answerState){
    _questionHistory.last.answerState = answerState;
    notifyListeners();
  }

  void setCurrentQuestionAnswerState(AnswerState state){
    _questionHistory.last.answerState = state;
    notifyListeners();
  }

  int getNumberOfQuestions(){
    return _questionHistory.length;
  }

  void revealCurrentQuestionAnswer(){
    _questionHistory.last.isRevealed = true;
    notifyListeners();
  }

  bool isCurrentQuestionRevealed(){
    return _questionHistory.last.isRevealed;
  }

  QuestionDetails getNthQuestionDetails(int n){
    return _questionHistory[n];
  }

  int getTotalHintAmount(){
    int totalHintsAmount = 0;

    QuestionDetails element;
    for(int i=0; i<_questionHistory.length; i++){
      element = _questionHistory[i];
      if(element.answerState == AnswerState.rightAnswer){
        totalHintsAmount += element.getHintAmount();
      }
    }

    return totalHintsAmount;
    return _questionHistory.fold(0, (prev, elem) => prev + elem.getHintAmount());
  }

  void addHintToCurrentQuestionWithSize(int size){
    _questionHistory.last.addHintWithSize(size);
    notifyListeners();
  }

  int getHintAmountOfCurrentQuestion(){
    return _questionHistory.last.getHintAmount();
  }

  List<CoordBox> getHintsOfCurrentQuestion(){
    // necessary for selectors to work
    return [..._questionHistory.last.hints];
  }

  bool isQuizFinished(){
    return _leftTitles.isEmpty;
  }

  List<Episode> getCurrentlyPossibleAnswers(){
    return _questionHistory.last.answerStack;
  }

  int getNumberOfAnsweredQuestions(){
    return _questionHistory.fold(0, (previousValue, element) => previousValue + ((element.answerState != AnswerState.unanswered) ? 1 : 0));
  }
  int getNumberOfCorrectlyAnsweredQuestions(){
    return _questionHistory.fold(0, (previousValue, element) => previousValue + ((element.answerState == AnswerState.rightAnswer) ? 1 : 0));
  }
}