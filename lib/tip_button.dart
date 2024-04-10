import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizzly/current_quiz_state.dart';

class TipButton extends StatefulWidget {
  const TipButton({super.key});

  @override
  State<TipButton> createState() => _TipButtonState();
}

class _TipButtonState extends State<TipButton> {
  final Random _random = Random();

  int _tipCost = 1;

  bool _isTipDeactivated = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<CurrentQuizState>(
      builder: (BuildContext context, CurrentQuizState currentQuizState, Widget? child) {
        String buttonText;
        if(currentQuizState.isCurrentQuestionRevealed()){
          // RESET
          _tipCost = 1;
          _isTipDeactivated = false;

          int tipCounter = currentQuizState.getHintAmountOfCurrentQuestion();
          buttonText = "$tipCounter Tips benutzt";
        } else if (_isTipDeactivated){
          buttonText = "Kein Tip mehr übrig";
        } else {
          buttonText = "Nächster Tip (-$_tipCost)";
        }

        return FilledButton(
            onPressed: (_isTipDeactivated || currentQuizState.isCurrentQuestionRevealed()) ? null : () {
              int tipCounter = currentQuizState.getHintAmountOfCurrentQuestion();

              int size = 0;
              bool toggle = false;
              int newTipCost = 0;
              if(tipCounter == 0 || tipCounter == 1){
                size = 40;
              } else if (tipCounter >=2 && tipCounter <= 4){
                size = 60;
              } else if (tipCounter >=5 && tipCounter <=6){
                size = 80;
              } else {
                size = 80;
                toggle = true;
              }

              currentQuizState.setCurrentQuestionPossiblePointsMinus(_tipCost);

              switch(tipCounter){
                case 0: newTipCost = 1; break;
                case 1:
                case 2:
                case 3: newTipCost = 2; break;
                case 4:
                case 5:
                case 6: newTipCost = 4; break;
              }

              currentQuizState.addHintToCurrentQuestionWithSize(size);

              setState(() {
                _isTipDeactivated = toggle;
                _tipCost = newTipCost;
              });
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
                if (states.contains(MaterialState.pressed)) {
                  return Colors.black;
                }
                return Colors.white;
              }),
              foregroundColor: MaterialStateProperty.resolveWith((states) {
                if (states.contains(MaterialState.pressed)) {
                  return Colors.white;
                }
                return Colors.black;
              }),
              shape: MaterialStateProperty.resolveWith((states) {
                return const ContinuousRectangleBorder(side: BorderSide(color: Colors.black));
              }),
              animationDuration: const Duration(milliseconds: 1),
              alignment: Alignment.centerLeft,
              padding: MaterialStateProperty.resolveWith((states) {
                return const EdgeInsets.symmetric(horizontal: 20, vertical: 13);
              }),
            ),
            child: Text(buttonText)
        );
      },
    );
  }
}
