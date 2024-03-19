import 'dart:math';

import 'Coord.dart';
import 'Episode.dart';

enum AnswerState { wrongAnswer, rightAnswer, unanswered }

class QuestionDetails {
  final int questionNumber;
  final List<Episode> answerStack;
  final int correctAnswerId;
  final String coverAssetPath;
  bool isRevealed = false;
  List<CoordBox> hints = [];
  AnswerState answerState = AnswerState.unanswered;
  int possiblePoints = 20;

  QuestionDetails({
    required this.questionNumber,
    required this.answerStack,
    required this.correctAnswerId,
    required this.coverAssetPath
  }) {
    Random random = Random();
    double x = random.nextInt(350-40).toDouble();
    double y = random.nextInt(350-40).toDouble();
    hints.add(CoordBox(x,y,40));
  }

  String getCorrectAnswerTitle(){
    return answerStack[correctAnswerId].title;
  }

  void addHintWithSize(int size){
    Random random = Random();
    double x = random.nextInt(350-size).toDouble();
    double y = random.nextInt(350-size).toDouble();

    hints.add(CoordBox(x,y,size.toDouble()));
  }

  int getHintAmount(){
    // first box does not count as hint
    return hints.length-1;
  }
}