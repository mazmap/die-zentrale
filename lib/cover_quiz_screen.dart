import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizzly/cover_display.dart';
import 'package:quizzly/episodes_service.dart';
import 'package:quizzly/finished_quiz_summary_screen.dart';
import 'package:quizzly/leave_round_dialog.dart';
import 'package:quizzly/slide_from_right_route.dart';
import 'package:quizzly/slide_from_top_down_route.dart';

import 'answer_selector.dart';
import 'answers_list.dart';
import 'current_quiz_state.dart';
import 'ongoing_quiz_summary_screen.dart';
import 'question_details.dart';
import 'tip_button.dart';

class CoverQuizScreen extends StatefulWidget {
  const CoverQuizScreen({super.key});

  @override
  State<CoverQuizScreen> createState() => _CoverQuizScreenState();
}

class _CoverQuizScreenState extends State<CoverQuizScreen> {

  late final QuestionDetails initialQuestion;

  late final String quiz_round_id;

  final ScrollController _listViewController = ScrollController();

  @override
  void initState() {
    super.initState();
    initialQuestion = CurrentQuizState.createInitialQuestion();
  }


  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CurrentQuizState.initializeWith(initialQuestion)),
        ChangeNotifierProvider(create: (context) => AnswersList(initialQuestion.correctAnswerId))
      ],
      child: PopScope(
        canPop: false,
        onPopInvoked: (didPop) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Hier gibt's kein zurück. Mit dem Kreuz oben links lässt sich allerdings die Runde vorzeitig beenden :)"))
          );
        },
        child: Scaffold(
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(40), // Set this height
              child: Container(
                  padding: EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top),
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    border: Border(
                      bottom: BorderSide(color: Colors.black)
                    )
                  ),
                  child: Row(
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        child: Consumer<CurrentQuizState>(
                          builder: (context, currentQuizState, child){
                            return FilledButton(
                              onPressed: () {
                                showGeneralDialog(
                                    context: context,
                                    barrierDismissible: true,
                                    barrierLabel: "popup_barrier",
                                    pageBuilder: (contextInternal, animation, secondaryAnimation) {
                                      return LeaveRoundDialog(currentQuizState: currentQuizState,);
                                    }
                                );
                                // Navigator.pop(context);
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
                                shape: MaterialStateProperty.all(
                                  const ContinuousRectangleBorder(borderRadius: BorderRadius.all(Radius.zero))
                                )
                              ),
                              child: const Icon(Icons.close_sharp, size:18),
                            );
                          },
                        ),
                      ),
                      Expanded(
                          child: Consumer<CurrentQuizState>(
                            builder: (context, currentQuizState, child) {
                              return GestureDetector(
                                onTap: (){
                                  Navigator.push(context, SlideFromTopDownRoute(page: OngoingQuizSummaryScreen(currentQuizState: currentQuizState,)));
                                },
                                child: Container(
                                    color: Colors.black,
                                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                    child: Text(
                                        "Frage ${currentQuizState.getNumberOfQuestions()}/${EpisodesService.getEpisodesAmount()}",
                                        style: const TextStyle(color: Colors.white)
                                    )
                                ),
                              );
                            }
                          )
                      ),
                      Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                              border: Border(
                                  left: BorderSide(
                                      color: Colors.black,
                                      width: 1
                                  ),
                                top: BorderSide(
                                    color: Colors.black,
                                    width: 1
                                ),
                              ),

                          ),
                          child: Selector<CurrentQuizState, int>(
                          selector: (BuildContext context, CurrentQuizState currentQuizState) {
                              return currentQuizState.getTotalPoints();
                            },
                            builder: (BuildContext context, int totalPoints, Widget? child) {
                              return Text("$totalPoints");
                            },
                          )
                      )
                    ],
                  )
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.only(left:15, right: 15, top: 15, bottom: 10),
              child: ListView(
                controller: _listViewController,
                children: <Widget>[
                  Selector<CurrentQuizState, String>(
                    builder: (_, currentCoverAssetPath, __) {
                      print("Init in Selector: $currentCoverAssetPath");
                      return CoverDisplay(coverAssetPath: currentCoverAssetPath, key: UniqueKey()); // UniqueKey is neccessary for correct rendering: https://medium.com/flutter/keys-what-are-they-good-for-13cb51742e7d
                    },
                    selector: (_, currentQuizState) {
                      print("Selector Method: ${currentQuizState.getLatestQuestionDetails().coverAssetPath}");
                      return currentQuizState.getLatestQuestionDetails().coverAssetPath;
                    },
                  ),
                  const SizedBox(height: 10),
                  IntrinsicHeight(
                    child: Row(
                      children: [
                        const Expanded(
                            child: TipButton()
                        ),
                        const SizedBox(width: 10),
                        Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black, strokeAlign: -1.0)
                            ),
                            alignment: Alignment.center,
                            child: Selector<CurrentQuizState, int>(
                              selector: (BuildContext context, CurrentQuizState currentQuizState) {
                                return currentQuizState.getCurrentlyPossiblePoints();
                              },
                              builder: (BuildContext context, int currentlyPossiblePoints, Widget? child) {
                                return Text("$currentlyPossiblePoints");
                              },
                            )
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Selector<CurrentQuizState, List<String>>(
                    builder: (BuildContext context, List<String> value, Widget? child) {
                      return AnswerSelector(possibleAnswers: value);
                    },
                    selector: (_, currentQuizState) => currentQuizState.getLatestQuestionDetails().answerStack.map((e) => "${e.title} (${e.number})").toList(),
                  )
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
                    child: Consumer2<AnswersList, CurrentQuizState>(
                        builder: (context, answersList, currentQuizState, child) {
                          if(currentQuizState.isCurrentQuestionRevealed()){
                            // SHOW NEXT QUESTION BUTTON
                            if(!currentQuizState.isQuizFinished()){
                              if(answersList.isCorrectAnswerSelected()){
                                return FilledButton(
                                    onPressed: () {
                                      QuestionDetails newQuestion = currentQuizState.createNewQuestion();
                                      answersList.resetAndUpdateWith(newQuestion.correctAnswerId);
                                      _listViewController.animateTo(0, duration: Duration(milliseconds: 300), curve: Curves.easeIn);
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
                                    child: const Text("Nächstes Cover")
                                );
                              } else {
                                return FilledButton(
                                    onPressed: () {
                                      // LOAD FINISH SCREEN
                                      Navigator.pushReplacement(context, SlideFromRightRoute(page: FinishedQuizSummaryScreen(finishedQuizstate: currentQuizState)));
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
                                    child: const Text("Runde beenden")
                                );
                              }
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text("Du hast alle Cover einmal richtig zugeordnet, Glückwunsch!"))
                              );
                              return FilledButton(
                                  onPressed: () {
                                    // LOAD FINISH SCREEN
                                    Navigator.pushReplacement(context, SlideFromRightRoute(page: FinishedQuizSummaryScreen(finishedQuizstate: currentQuizState)));
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
                                  child: const Text("Runde beenden")
                              );
                            }
                          } else {
                            // SHOW ANSWER BUTTON
                            return FilledButton(
                                onPressed: () async {
                                  if(answersList.isOneSelected()){
                                    currentQuizState.revealCurrentQuestionAnswer();
                                    if(answersList.isCorrectAnswerSelected()){
                                      // RIGHT ANSWER
                                      currentQuizState.completeCurrentQuestion(AnswerState.rightAnswer);
                                    } else {
                                      // WRONG ANSWER
                                      currentQuizState.completeCurrentQuestion(AnswerState.wrongAnswer);
                                    }
                                    _listViewController.animateTo(0, duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
                                    if(currentQuizState.getNumberOfQuestions() == 1){
                                      DocumentReference newQuizRound = FirebaseFirestore.instance.collection("cover_quiz_rounds").doc();
                                      quiz_round_id = newQuizRound.id;
                                      newQuizRound.set({
                                        "user": FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid),
                                        "total_points": currentQuizState.getTotalPoints(),
                                        "hints_amount": currentQuizState.getTotalHintAmount(),
                                        "correctly_answered_amount": currentQuizState.getNumberOfCorrectlyAnsweredQuestions(),
                                        "created_at": DateTime.now()
                                      });
                                    }

                                    FirebaseFirestore.instance.collection("answered_questions").add({
                                      "cover_quiz_round_ref": FirebaseFirestore.instance.doc("cover_quiz_rounds/$quiz_round_id"),
                                      "correct_answer_ref": FirebaseFirestore.instance.doc("episodes/${currentQuizState.getLatestQuestionDetails().getCorrectAnswerEpisode().id}"),
                                      "achieved_points": currentQuizState.getCurrentlyPossiblePoints(),
                                      "correctly_answered": answersList.isCorrectAnswerSelected(),
                                      "currently_selected_answer": answersList.getActiveId(),
                                      "hints": currentQuizState.getHintsOfCurrentQuestion().map((e) => e.toFirestoreObj()),
                                      "history_index": currentQuizState.getNumberOfQuestions()-1,
                                      "possible_answers_refs": currentQuizState.getCurrentlyPossibleAnswers().map((e){
                                        return FirebaseFirestore.instance.doc("episodes/${e.id}");
                                      })
                                    });

                                    FirebaseFirestore.instance.collection("cover_quiz_rounds").doc(quiz_round_id).update({
                                      "updated_at": FieldValue.serverTimestamp(),
                                      "correctly_answered_amount": currentQuizState.getNumberOfCorrectlyAnsweredQuestions(),
                                      "total_points": currentQuizState.getTotalPoints(),
                                      "hints_amount": currentQuizState.getTotalHintAmount()
                                    });
                                  } else {
                                    // NO ANSWER SELECTED
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text("Keine Antwort ausgewählt!"))
                                    );
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
                                child: const Text("Antworten")
                            );
                          }
                        }
                    )
                )
            )
        ),
      ),
    );
  }
}
