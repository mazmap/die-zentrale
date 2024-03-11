import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:quizzly/HomeRoute.dart';
import 'package:quizzly/SlideFromLeftRoute.dart';
import 'package:quizzly/SlideOffToRight.dart';

class LeaveRoundDialog extends StatelessWidget {
  final Widget parent;

  const LeaveRoundDialog({super.key, required this.parent});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      insetPadding: const EdgeInsets.all(40),
      shape: const ContinuousRectangleBorder(),
      child: IntrinsicHeight(
        child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black)
                    ),
                    child: Text(
                        "Achtung!",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                        )
                    ),
                  ),

                  Container(
                    padding: const EdgeInsets.all(15),
                    decoration: const BoxDecoration(
                      border: Border(
                        left: BorderSide(color: Colors.black),
                        right: BorderSide(color: Colors.black)
                      )
                    ),
                    child: const Text(
                      "Du bist dabei diese Runde zu verlassen. Das speichert zwar dein jetztiges Ergebnis, allerdings kannst du diese Runde dann nicht mehr weiterspielen. Möchtest du trotzdem fortfahren?",
                      softWrap: true,
                    ),
                  ),

                  Container(
                    height: 50,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black)
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border(
                                right: BorderSide()
                              )
                            ),
                            child: FilledButton(
                              onPressed: (){
                                Navigator.pop(context);
                              },
                              child: Text("Nein"),
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.resolveWith((states) {
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
                                  return const ContinuousRectangleBorder();
                                }),
                                animationDuration: const Duration(milliseconds: 1),
                              )
                            ),
                          ),
                        ),
                        Expanded(
                          child: FilledButton(
                              onPressed: (){
                                Navigator.pop(context);
                                // necessary as this dialog could also be above
                                Navigator.pushReplacement(context, SlideOffToRight(target: HomeRoute(), parent: parent));
                              },
                              child: Text("Ja"),
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.resolveWith((states) {
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
                                  return const ContinuousRectangleBorder();
                                }),
                                animationDuration: const Duration(milliseconds: 1),
                              )
                          ),
                        ),
                      ],
                    ),
                  )
                ]
            )
        ),
      ),
    );;
  }
}
