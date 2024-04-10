import 'package:flutter/material.dart';
import 'package:quizzly/current_quiz_state.dart';

import 'episode_quiz_summary_tile.dart';
import 'question_details.dart';

class FinishedQuizSummaryScreen extends StatelessWidget {
  final CurrentQuizState finishedQuizstate;

  const FinishedQuizSummaryScreen({super.key, required this.finishedQuizstate});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(40), // Set this height
          child: Container(
              color: Colors.black,
              padding: EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top),
              child: Container(
                  color: Colors.black,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: const Text("Übersicht dieser Runde", style: TextStyle(color: Colors.white))
              )
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Column(
                children: [
                  Container(
                    color: Colors.black,
                    padding: EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Expanded(child: Text("Gesamtpunktzahl", style: TextStyle(color: Colors.white), softWrap: true,)),
                        Text(
                            "${finishedQuizstate.getTotalPoints()}",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 64,
                            height: .8,
                            fontWeight: FontWeight.bold
                          ),
                        )
                      ]
                    ),
                  ),
                  const SizedBox(height: 10,),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black)
                          ),
                          padding: EdgeInsets.all(10),
                          child: Column(
                            children:[
                              Text(
                                  "${finishedQuizstate.getNumberOfAnsweredQuestions()}",
                                  style: TextStyle(
                                      fontSize: 36,
                                      fontWeight: FontWeight.bold
                                  )
                              ),
                              const Text("Erratene Cover")
                            ]
                          )
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black)
                            ),
                            padding: EdgeInsets.all(10),
                            child: Column(
                                children:[
                                  Text(
                                    "${finishedQuizstate.getTotalHintAmount()}",
                                    style: TextStyle(
                                      fontSize: 36,
                                      fontWeight: FontWeight.bold
                                    )
                                  ),
                                  const Text("Verwendete Tips")
                                ]
                            )
                        ),
                      )
                    ]
                  ),
                  const SizedBox(height: 20),
                  Text("Die Cover dieser Runde:"),
                  const SizedBox(height: 10),
                ]
              ),
              Expanded(
                child: (finishedQuizstate.getNumberOfAnsweredQuestions() != 0) ? ListView.separated(
                    itemCount: finishedQuizstate.getNumberOfQuestions(),
                    separatorBuilder: (context, index){
                      return SizedBox(height: 10);
                    },
                    itemBuilder: (context, index) {
                      int questionAmount = finishedQuizstate.getNumberOfQuestions();
                      QuestionDetails question = finishedQuizstate.getNthQuestionDetails(index);
                      if(index < questionAmount-1){
                        return EpisodeQuizSummaryTile(
                          questionDetails: question,
                        );
                      } else {
                        // DIFFERENTIATE BETWEEN isRevealed + rightAnswer or wrongAnswer
                        if(question.isRevealed){
                          return EpisodeQuizSummaryTile(
                            questionDetails: question,
                          );
                        }
                      }
                    }
                ) : Text(
                  "Du hast in dieser Runde noch kein Cover geraten. Deshalb wird sie auch nicht gespeichert und demnach auch nicht in den \"Aktuellsten Spielen\" aufgeführt. Du brauchst dich deshalb also nicht zu wundern :)"
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
                      Navigator.pop(context);
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
                    child: Text("Zurück zur Quiz-Seite")
                )
            )
        ),
      ),
    );
  }
}
