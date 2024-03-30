import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:quizzly/AcceptDeclineDialog.dart';
import 'package:quizzly/CurrentQuizState.dart';
import 'package:quizzly/QuestionDetails.dart';

import 'FinishedQuizSummaryScreen.dart';
import 'SlideFromRightRoute.dart';

class LeaveRoundDialog extends StatelessWidget {
  final CurrentQuizState currentQuizState;

  const LeaveRoundDialog({super.key, required this.currentQuizState});

  @override
  Widget build(BuildContext context) {
    return AcceptDeclineDialog(
        title: "Achtung!",
        infoText: "Du bist dabei diese Runde zu verlassen. Das speichert zwar dein jetztiges Ergebnis, allerdings kannst du diese Runde dann nicht mehr weiterspielen. Möchtest du trotzdem fortfahren?",
        acceptText: "Ja",
        declineText: "Nein",
        onAccept: () {
          Navigator.pushAndRemoveUntil(context, SlideFromRightRoute(page: FinishedQuizSummaryScreen(finishedQuizstate: currentQuizState,)), (route) {
            return route.settings.name == "CoverQuizHome";
          });
        },
        onDecline: () {}
    );
  }
}
