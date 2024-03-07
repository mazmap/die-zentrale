import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'AnswersList.dart';

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

  @override
  Widget build(BuildContext context) {
    return Consumer<AnswersList>(
      builder: (context, answersList, child) {
        if(answersList.activeId != widget.answerId){
          _active = false;
        }

        return GestureDetector(
          onTap: () {
            if(_active) {
              answersList.setActive(-1);
            } else {
              answersList.setActive(widget.answerId);
            }
            setState(() {
              _active = !_active;
            });
          },
          onLongPress: () {

          },
          child: Container(
              color: (_active) ? Colors.black : Colors.white,
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 17),
                    decoration: BoxDecoration(
                        border: Border(
                            right: BorderSide(
                                color: (_active) ? Colors.white : Colors.black
                            )
                        )
                    ),
                    child: Text(
                      letters.characters.elementAt(widget.answerId),
                      style: TextStyle(
                          color: (_active) ? Colors.white : Colors.black
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    flex: 1,
                    child: Tooltip(
                      message: "${widget.answerText}",
                      child: Text(
                        widget.answerText,
                        overflow: TextOverflow.fade,
                        softWrap: false,
                        style: TextStyle(
                            color: (_active) ? Colors.white : Colors.black
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
  }
}
