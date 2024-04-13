import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizzly/screens/play/cover_quiz/current_quiz_state.dart';

import 'answers_list.dart';

class AnswerButton extends StatefulWidget {
  final int answerId;
  final String answerText;

  const AnswerButton({super.key, required this.answerId, required this.answerText});

  @override
  State<AnswerButton> createState() => _AnswerButtonState();
}

class _AnswerButtonState extends State<AnswerButton> {
  bool _active = false;
  
  final String letters = "ABCDEFGHIJKLMNOPQRSTUVW";

  Color _backgroundColor = Colors.white;
  Color _color = Colors.black;

  void _toggleColors(){
    setState(() {
      _backgroundColor = (_active) ? Colors.black : Colors.white;
      _color = (_active) ? Colors.white : Colors.black;
    });
  }

  void _setColorsDefaults(){
    _backgroundColor = (_active) ? Colors.black : Colors.white;
    _color = (_active) ? Colors.white : Colors.black;
  }

  void _setRevealedColors(bool correct){
    _backgroundColor = (correct) ? Color.fromRGBO(0, 255, 37, 1) : Color.fromRGBO(255, 0, 62, 1);
    _color = (correct) ? Colors.black : Colors.white;
  }


  @override
  Widget build(BuildContext context) {
    return Selector<CurrentQuizState, bool>(
      selector: (BuildContext context, CurrentQuizState currentQuizState) {
        return currentQuizState.isCurrentQuestionRevealed();
      },
      builder: (BuildContext context, bool isCurrentQuestionRevealed, Widget? child) {
        return Consumer<AnswersList>(
            builder: (context, answersList, child) {
              if(!answersList.isActiveId(widget.answerId)){
                _active = false;
                _setColorsDefaults();
              }

              if(isCurrentQuestionRevealed){
                if(answersList.isCorrectAnswer(widget.answerId)){
                  // highlight correct answer
                  _setRevealedColors(true);
                } else {
                  if(_active){
                    // highlight wrong answer
                    _setRevealedColors(false);
                  }
                }
              }

              return GestureDetector(
                onTap: () {
                  if(!isCurrentQuestionRevealed){
                    if(_active) {
                      // deselect answer option
                      answersList.setActive(-1);
                    } else {
                      answersList.setActive(widget.answerId);
                    }
                    _active = !_active;
                    _toggleColors();
                  } else {
                    // do nothing
                  }
                },
                child: Container(
                    color: _backgroundColor,
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 17),
                          decoration: BoxDecoration(
                              border: Border(
                                  right: BorderSide(
                                    color: _color,
                                  )
                              )
                          ),
                          child: Text(
                            letters.characters.elementAt(widget.answerId),
                            style: TextStyle(
                              color: _color,
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          flex: 1,
                          child: Tooltip(
                              message: widget.answerText,
                              margin: const EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                widget.answerText,
                                overflow: TextOverflow.fade,
                                softWrap: false,
                                style: TextStyle(
                                    color: _color
                                ),
                              )
                          ),
                        ),
                        const SizedBox(width: 10)
                      ],
                    )
                ),
              );
            }
        );
      },
    );
  }
}
