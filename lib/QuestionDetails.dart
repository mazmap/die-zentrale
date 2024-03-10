import 'package:flutter/material.dart';

enum QuestionAnswerState { wrongAnswer, rightAnswer }

class QuestionDetails {
  final int questionNumber;
  final List<String> answerStack;
  final int correctAnswerId;
  final String coverAssetPath;

  late QuestionAnswerState questionAnswerState;

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