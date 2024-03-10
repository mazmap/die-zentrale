import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quizzly/CurrentQuizState.dart';

class OngoingQuizSummaryRoute extends StatelessWidget {
  final CurrentQuizState currentQuizState;

  const OngoingQuizSummaryRoute({super.key, required this.currentQuizState});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(40), // Set this height
        child: Container(
            color: Colors.white,
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
                  child: FilledButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ButtonStyle(
                      alignment: Alignment.center,
                      backgroundColor: MaterialStateProperty.resolveWith((states) {
                        return Colors.white;
                      }),
                      iconColor: MaterialStateProperty.resolveWith((states) {
                        return Colors.black;
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
            Expanded(
              child: ListView.builder(
                  padding: EdgeInsets.only(top: 15),
                  itemCount: currentQuizState.getNumberOfQuestions(),
                  itemBuilder: (context, index) {
                    int questionAmount = currentQuizState.getNumberOfQuestions();
                    if(index < questionAmount-1){
                      return Text(currentQuizState.getNthQuestionDetails(index).getCorrectAnswerTitle());
                    } else {
                      // DIFFERENTIATE BETWEEN isRevealed + rightAnswer or wrongAnswer
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
                    Navigator.pop(context);
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
                  child: Text("Vorzeitig Runde beenden")
              )
          )
      ),
    );;
  }
}
