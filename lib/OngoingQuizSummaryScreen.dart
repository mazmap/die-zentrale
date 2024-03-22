import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quizzly/CurrentQuizState.dart';
import 'package:quizzly/EpisodeQuizSummaryTile.dart';
import 'package:quizzly/CoverQuizHomeScreen.dart';
import 'package:quizzly/FinishedQuizSummaryScreen.dart';
import 'package:quizzly/QuestionDetails.dart';
import 'package:quizzly/SlideFromRightRoute.dart';

import 'LeaveRoundDialog.dart';
import 'SlideOffToRight.dart';

class OngoingQuizSummaryScreen extends StatelessWidget {
  final CurrentQuizState currentQuizState;

  const OngoingQuizSummaryScreen({super.key, required this.currentQuizState});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(40), // Set this height
        child: Container(
            color: Colors.black,
            padding: EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top),
            child: Row(
              children: [
                Container(
                  decoration: const BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: Colors.black,
                              width: 1
                          ),
                          right: BorderSide(
                              color: Colors.black,
                              width: 1
                          )
                      )
                  ),
                  height: 50,
                  width: 50,
                  child: FilledButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ButtonStyle(
                      alignment: Alignment.center,
                      backgroundColor: MaterialStateProperty.resolveWith((states) {
                        return Colors.black;
                      }),
                      iconColor: MaterialStateProperty.resolveWith((states) {
                        return Colors.white;
                      }),
                      surfaceTintColor: MaterialStateProperty.resolveWith((states) {
                        return Colors.black;
                      }),
                      padding: MaterialStateProperty.resolveWith((states) {
                        return const EdgeInsets.symmetric(horizontal: 5);
                      }),
                      minimumSize: MaterialStateProperty.resolveWith((states) {
                        return const Size(10,10);
                      }),
                    ),
                    child: const Icon(Icons.arrow_back, size:18),
                  ),
                ),
                Expanded(
                  child: Container(
                      color: Colors.black,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: const Text("Übersicht dieser Runde", style: TextStyle(color: Colors.white))
                  ),
                )
              ],
            )
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Column(
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Gesamtpunktzahl bisher:"),
                        Text("${currentQuizState.getTotalPoints()}")
                      ]
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Insgesamt bisher verwendete Tips:"),
                        Text("${currentQuizState.getTotalHintAmount()}")
                      ]
                  )
                ]
            ),
            const SizedBox(height: 15),
            Expanded(
              child: ListView.separated(
                  itemCount: currentQuizState.getNumberOfQuestions(),
                  separatorBuilder: (context, index){
                    return SizedBox(height: 10);
                  },
                  itemBuilder: (context, index) {
                    int questionAmount = currentQuizState.getNumberOfQuestions();
                    QuestionDetails question = currentQuizState.getNthQuestionDetails(index);
                    if(index < questionAmount-1){
                      print(question.getHintAmount());
                      return EpisodeQuizSummaryTile(
                          coverAssetPath: question.coverAssetPath,
                          title: question.getCorrectAnswerTitle(),
                          hints: question.getHintAmount(),
                          points: question.possiblePoints
                      );
                    } else {
                      // DIFFERENTIATE BETWEEN isRevealed + rightAnswer or wrongAnswer
                      if(question.isRevealed){
                        return EpisodeQuizSummaryTile(
                            coverAssetPath: question.coverAssetPath,
                            title: question.getCorrectAnswerTitle(),
                            hints: question.getHintAmount(),
                            points: question.possiblePoints
                        );
                      }
                      return Text("?");
                    }
                  }
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
          elevation: 0,
          height: 70,
          padding: EdgeInsets.zero,
          child: Container(
              decoration: const BoxDecoration(
                border: Border(
                    top: BorderSide(
                        color: Colors.black
                    )
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: FilledButton(
                  onPressed: () {
                    showGeneralDialog(
                        context: context,
                        barrierDismissible: true,
                        barrierLabel: "popup_barrier",
                        pageBuilder: (contextInternal, animation, secondaryAnimation) {
                          return LeaveRoundDialog(currentQuizState: currentQuizState,);
                        }
                    );
                  },
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
                      return const ContinuousRectangleBorder(side: BorderSide(color: Colors.black));
                    }),
                    animationDuration: const Duration(milliseconds: 1),
                    fixedSize: MaterialStateProperty.resolveWith((states) {
                      return Size(0, 50);
                    }),
                  ),
                  child: Text("Vorzeitig Runde beenden")
              )
          )
      ),
    );;
  }
}
