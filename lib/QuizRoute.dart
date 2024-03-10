import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:quizzly/CoverDisplay.dart';
import 'package:quizzly/SimpleTextButton.dart';

import 'AnswerSelector.dart';
import 'AnswersList.dart';
import 'CurrentQuizState.dart';
import 'Episodes.dart';
import 'HintsMask.dart';
import 'HintsNotifier.dart';
import 'QuestionDetails.dart';
import 'TipButton.dart';

class QuizRoute extends StatefulWidget {
  const QuizRoute({super.key});

  @override
  State<QuizRoute> createState() => _QuizRouteState();
}

class _QuizRouteState extends State<QuizRoute> {

  late final QuestionDetails initialQuestion;

  @override
  void initState() {
    super.initState();
    initialQuestion = CurrentQuizState.createInitialQuestion();
    print(initialQuestion.coverAssetPath);
  }


  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CurrentQuizState.initializeWith(initialQuestion)),
        ChangeNotifierProvider(create: (context) => HintsNotifier()),
        ChangeNotifierProvider(create: (context) => AnswersList(initialQuestion.correctAnswerId))
      ],
      child: Scaffold(
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
                            child: Consumer<CurrentQuizState>(
                                builder: (context, currentQuizState, child) {
                                  return Text(
                                      "Frage ${currentQuizState.getLatestQuestionDetails().questionNumber}/200",
                                      style: const TextStyle(color: Colors.white)
                                  );
                                }
                            )
                        )
                    ),
                    Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        decoration: const BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: Colors.black,
                                    width: 1
                                ),
                                left: BorderSide(
                                    color: Colors.black,
                                    width: 1
                                )
                            )
                        ),
                        child: Consumer<CurrentQuizState>(
                            builder: (context, currentPoints, child){
                              return Text(
                                  "${currentPoints.totalPoints}"
                              );
                            }
                        )
                    )
                  ],
                )
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.only(left:15, right: 15, top: 15, bottom: 10),
            child: ListView(
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
                Row(
                  children: [
                    const Expanded(
                        child: TipButton()
                    ),
                    const SizedBox(width: 10),
                    Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black)
                        ),
                        child: Consumer<CurrentQuizState>(
                            builder: (context, currentPoints, child){
                              return Text(
                                  "${currentPoints.localPoints}"
                              );
                            }
                        )
                    )
                  ],
                ),
                const SizedBox(height: 10),
                Selector<CurrentQuizState, List<String>>(
                  builder: (BuildContext context, List<String> value, Widget? child) {
                    return AnswerSelector(possibleAnswers: value);
                  },
                  selector: (_, currentQuizState) => currentQuizState.getLatestQuestionDetails().answerStack,
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
                  child: Consumer3<AnswersList, CurrentQuizState, HintsNotifier>(
                      builder: (context, answersList, currentPoints, hintsNotifier, child) {
                        return FilledButton(
                            onPressed: () {
                              if(answersList.isOneSelected()){
                                answersList.reveal();
                                if(answersList.isCorrectAnswerSelected()){
                                  currentPoints.setTotalPlusLocal();
                                  QuestionDetails newQuestion = currentPoints.createNewQuestion();
                                  answersList.resetAndUpdateWith(newQuestion.correctAnswerId);
                                  hintsNotifier.reset();
                                  print("Right Answer");
                                } else {
                                  print("Wrong Answer");
                                }
                              } else {
                                print("No active Button");
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
                            child: Text("Antworten")
                        );
                      }
                  )
              )
          )
      ),
    );
  }
}
