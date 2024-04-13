import 'package:flutter/material.dart';
import 'package:quizzly/screens/play/cover_quiz/answer_button.dart';
import 'package:quizzly/screens/play/cover_quiz/vertical_answer_divider.dart';

class AnswerSelector extends StatefulWidget {
  final List<String> possibleAnswers;

  const AnswerSelector({super.key, required this.possibleAnswers});

  @override
  State<AnswerSelector> createState() => _AnswerSelectorState();
}

class _AnswerSelectorState extends State<AnswerSelector> {
  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];

    for(int i=0; i<widget.possibleAnswers.length-1; i++){
      children.add(AnswerButton(answerId: i, answerText: widget.possibleAnswers[i],));
      children.add(const VerticalAnswerDivider());
    }
    children.add(AnswerButton(answerId: widget.possibleAnswers.length-1, answerText: widget.possibleAnswers.last));
    // children.add(AnswerButton(answerId: 6, answerText: "Hallo das hier ist ein sehr langer Text, der noch viel weiter geht als alles möglich sein sollte"));

    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black)
      ),
      child: Column(
        children: children,
      )
    );
  }
}
