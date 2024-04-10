import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizzly/cover_review_display.dart';
import 'package:quizzly/episodes_service.dart';
import 'package:quizzly/ongoing_quiz_aq_state.dart';
import 'package:quizzly/ongoing_quiz_review_answer_tile.dart';

import 'question_details.dart';

class OngoingQuizAnsweredQuestionScreen extends StatelessWidget {
  final QuestionDetails questionDetails;
  const OngoingQuizAnsweredQuestionScreen({super.key, required this.questionDetails});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) {
        return OngoingQuizAQState(hints: questionDetails.hints);
      },
      child: Scaffold(
        backgroundColor: Colors.white,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(40),
            child: Container(
                color: Colors.black,
                padding: EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top),
                child: Stack(
                  children: [
                    Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        alignment: Alignment.center,
                        child: Text(
                            "Rückblick | Frage ${questionDetails.questionNumber}/${EpisodesService.getEpisodesAmount()}",
                            style: TextStyle(color: Colors.white)
                        )
                    ),
                    Container(
                      height: 50,
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
                          padding: MaterialStateProperty.resolveWith((states) {
                            return const EdgeInsets.symmetric(horizontal: 15);
                          }),
                          minimumSize: MaterialStateProperty.resolveWith((states) {
                            return const Size(10,10);
                          }),
                        ),
                        child: const Icon(Icons.arrow_back, size:18),
                      ),
                    ),
                  ],
                )
            ),
          ),
          body: Padding(
              padding: const EdgeInsets.only(left:15, right: 15, top: 15, bottom: 10),
              child: ListView(
                  children: [
                    CoverReviewDisplay(coverAssetPath: questionDetails.coverAssetPath),
                    const SizedBox(height: 10),
                    IntrinsicHeight(
                      child: Row(
                        children: [
                          Expanded(
                            child: Material(
                              color: Colors.white,
                              child: Consumer<OngoingQuizAQState>(
                                  builder: (context, state, child){
                                    return InkWell(
                                        onTap: () {
                                          state.popLatestHint();
                                        },
                                        child: Container(
                                            decoration: BoxDecoration(
                                                border: Border.all(color: Colors.black)
                                            ),
                                            padding: EdgeInsets.symmetric(vertical: 13),
                                            child: Icon(Icons.arrow_back_sharp, size:18)
                                        )
                                    );
                                  }
                              )
                            ),
                          ),
                          const SizedBox(width: 10),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.black, strokeAlign: -0.5),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            margin: EdgeInsets.zero,
                            alignment: Alignment.center,
                            child: Consumer<OngoingQuizAQState>(
                              builder: (context, state, child){
                                return  Text("${state.getRevealedHintAmount()}/${questionDetails.getHintAmount()} Tips");
                              }
                            )
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Material(
                                color: Colors.white,
                                child: Consumer<OngoingQuizAQState>(
                                  builder: (context, state, child){
                                    return InkWell(
                                        onTap: () {
                                          state.loadNextHint();
                                        },
                                        child: Container(
                                            decoration: BoxDecoration(
                                                border: Border.all(color: Colors.black)
                                            ),
                                            padding: EdgeInsets.symmetric(vertical: 13),
                                            child: Icon(Icons.arrow_forward_sharp, size:18)
                                        )
                                    );
                                  }
                                )
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    OngoingQuizReviewAnswerTile(
                      possibleAnswers: questionDetails.answerStack,
                      correctAnswerId: questionDetails.correctAnswerId,
                      isCorrect: questionDetails.answerState == AnswerState.rightAnswer
                    )
                  ]
              )
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
                child: Consumer<OngoingQuizAQState>(
                  builder: (context, state, child){
                    return FilledButton(
                        onPressed: () {
                          if(state.isRevealed()){
                            state.hide();
                          } else {
                            state.reveal();
                          }
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
                        child: (state.isRevealed()) ? Text("Antwort verstecken") : Text("Antwort zeigen")
                    );
                  }
                )
            )
        ),
      ),
    );
  }
}
