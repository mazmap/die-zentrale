import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quizzly/AnswerButton.dart';
import 'package:quizzly/VerticalAnswerDivider.dart';

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
        children: [
          FilledButton(
              onPressed: () {  },
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith((states) {
                    // If the button is pressed, return green, otherwise blue
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
                    return ContinuousRectangleBorder();
                  }),
                  animationDuration: Duration(milliseconds: 1),
                  alignment: Alignment.centerLeft,
                  side: MaterialStateProperty.resolveWith((states) {
                    return BorderSide(color: Colors.black);
                  }),
                  padding: MaterialStateProperty.resolveWith((states) {
                    return EdgeInsets.zero;
                  }),
              ),
              child: Row(
                children: [
                  Container(
                    height: 40,
                    width: 40,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border(
                        right: BorderSide(
                          color: Colors.black
                        )
                      )
                    ),
                    child: Text("A")
                  ),
                  SizedBox(width: 20),
                  Text("und der Superpapagei (001)")
                ]
              )
          ),
          FilledButton(
              onPressed: () {  },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith((states) {
                  // If the button is pressed, return green, otherwise blue
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
                  return ContinuousRectangleBorder();
                }),
                animationDuration: Duration(milliseconds: 1),
                alignment: Alignment.centerLeft,
                side: MaterialStateProperty.resolveWith((states) {
                  return BorderSide(color: Colors.black);
                }),
                padding: MaterialStateProperty.resolveWith((states) {
                  return EdgeInsets.all(0);
                }),
              ),
              child: Row(
                  children: [
                    Container(
                        height: 40,
                        width: 40,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            border: Border(
                                right: BorderSide(
                                    color: Colors.black
                                )
                            )
                        ),
                        child: Text("B")
                    ),
                    SizedBox(width: 20),
                    Text("Grusel auf Dingsbums Castle (051)")
                  ]
              )
          ),
          AnswerButton(),
          VerticalAnswerDivider(),
          AnswerButton(),
        ],
      ),
    );
  }
}
