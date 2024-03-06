import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizzly/AnswerButton.dart';
import 'package:quizzly/VerticalAnswerDivider.dart';

import 'AnswersList.dart';

class AnswerSelector extends StatefulWidget {
  const AnswerSelector({super.key});

  @override
  State<AnswerSelector> createState() => _AnswerSelectorState();
}

class _AnswerSelectorState extends State<AnswerSelector> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black)
      ),
      child: Column(
        children: const [
          AnswerButton(answerId: 0,),
          VerticalAnswerDivider(),
          AnswerButton(answerId: 1,),
          VerticalAnswerDivider(),
          AnswerButton(answerId: 2,),
          VerticalAnswerDivider(),
          AnswerButton(answerId: 3,),
          VerticalAnswerDivider(),
          AnswerButton(answerId: 4,),
          VerticalAnswerDivider(),
          AnswerButton(answerId: 5,),
        ],
      )
    );
  }
}
