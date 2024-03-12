import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quizzly/CurrentQuizState.dart';

class FinishedQuizSummaryRoute extends StatelessWidget {
  final CurrentQuizState finishedQuizstate;

  const FinishedQuizSummaryRoute({super.key, required this.finishedQuizstate});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(40), // Set this height
          child: Container(
              color: Colors.white,
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Gesamtpunktzahl der Runde:"),
                      Text("${finishedQuizstate.getTotalPoints()}")
                    ]
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Insgesamt verwendete Tips:"),
                      Text("${finishedQuizstate.getTotalHintAmount()}")
                    ]
                  )
                ]
              ),
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.only(top: 15),
                  itemCount: finishedQuizstate.getNumberOfQuestions(),
                  itemBuilder: (context, index) {
                    return Text(finishedQuizstate.getNthQuestionDetails(index).getCorrectAnswerTitle());
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
                    child: Text("Zurück zu Home")
                )
            )
        ),
      ),
    );
  }
}
