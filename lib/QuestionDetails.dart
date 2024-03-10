import 'Coord.dart';

enum AnswerState { wrongAnswer, rightAnswer, unanswered }

class QuestionDetails {
  final int questionNumber;
  final List<String> answerStack;
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
  });

  String getCorrectAnswerTitle(){
    return answerStack[correctAnswerId];
  }
}