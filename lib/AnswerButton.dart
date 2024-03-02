import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'AnswersList.dart';

class AnswerButton extends StatefulWidget {
  final answerId;

  const AnswerButton({super.key, required this.answerId});

  @override
  State<AnswerButton> createState() => _AnswerButtonState();
}

class _AnswerButtonState extends State<AnswerButton> {
  bool _active = false;

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
            print("Long Press!");
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
                      "A",
                      style: TextStyle(
                          color: (_active) ? Colors.white : Colors.black
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Text(
                    "und der Superpapagei (001)",
                    style: TextStyle(
                        color: (_active) ? Colors.white : Colors.black
                    ),
                  )
                ],
              )
          ),
        );
      }
    );
  }
}
