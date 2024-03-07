import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'AnswerSelector.dart';
import 'AnswersList.dart';
import 'CurrentPoints.dart';
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

Future<ui.Image> _loadImage(String imageAssetPath, Size? size) async {
  final ByteData data = await rootBundle.load(imageAssetPath);
  final codec = await ui.instantiateImageCodec(
    data.buffer.asUint8List(),
    targetHeight: (size == null) ? 0 : size.width.toInt()-30,
    targetWidth: (size == null) ? 0 : size.width.toInt()-30,
  );
  var frame = await codec.getNextFrame();
  return frame.image;
}

String generateEpCoverAssetPath(String episodeName) {
  int episodeNumber = Episodes.episodeTitles.indexOf(episodeName)+1;
  String stringifiedEpNumber = "00$episodeNumber";
  stringifiedEpNumber = stringifiedEpNumber.substring(stringifiedEpNumber.length-3, stringifiedEpNumber.length);
  return stringifiedEpNumber;
}

class _QuizRouteState extends State<QuizRoute> {
  final Random _random = Random();

  List<String> leftTitles = [];

  int currentQuestionNumber = 1;

  int correctAnswer = -1;

  List<String> possibleAnswers = [];
  String currentEpCoverPath = "";

  @override
  void initState() {
    super.initState();

    leftTitles = Episodes.episodeTitles.getRange(0, 201).toList();
    List<String> titlesForSelection = [...leftTitles];

    int randomIdx;
    for(int i=0; i<6; i++){
      randomIdx = _random.nextInt(leftTitles.length-1-i);
      possibleAnswers.add(titlesForSelection[randomIdx]);
      titlesForSelection.removeAt(randomIdx);
    }

    correctAnswer = _random.nextInt(5);
    leftTitles.remove(possibleAnswers[correctAnswer]);

    String stringifiedEpNumber = generateEpCoverAssetPath(possibleAnswers[correctAnswer]);
    currentEpCoverPath = "assets/illustrations/illustration-folge-$stringifiedEpNumber.png";
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AnswersList()),
        ChangeNotifierProvider(create: (context) => CurrentPoints()),
        ChangeNotifierProvider(create: (context)=>HintsNotifier()),
        ChangeNotifierProvider(create: (context) => QuestionDetails())
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
                            child: Consumer<QuestionDetails>(
                                builder: (context, questionDetails, child) {
                                  return Text(
                                      "Frage ${questionDetails.questionNumber}/200",
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
                        child: Consumer<CurrentPoints>(
                            builder: (context, currentPoints, child){
                              return Text(
                                  "${currentPoints.total}"
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
                Consumer<HintsNotifier>(
                    builder: (context, hintsNotifier, child) {
                      return FutureBuilder<ui.Image>(
                          future: _loadImage(currentEpCoverPath, MediaQuery.of(context).size),
                          builder: (BuildContext context, AsyncSnapshot<ui.Image> snapshot) {
                            double deviceWidth = MediaQuery.of(context).size.width;
                            if(snapshot.hasData){
                              return Container(
                                color: Colors.black,
                                child: Align(
                                  alignment: Alignment.center,
                                  child: CustomPaint(
                                    foregroundPainter: HintsMask(snapshot.data!, hintsNotifier.hintCoords, hintsNotifier.isRevealed),
                                    size: Size(deviceWidth-30, deviceWidth-30),
                                  ),
                                ),
                              );
                            }
                            return Container(
                              color: Colors.black,
                              height: deviceWidth-30,
                              width: deviceWidth-30,
                              child: const Center(
                                child: Text(
                                    "Cover wird geladen...",
                                  style: TextStyle(color: Colors.white),
                                )
                              )
                            );
                          }
                      );
                    }
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
                        child: Consumer<CurrentPoints>(
                            builder: (context, currentPoints, child){
                              return Text(
                                  "${currentPoints.local}"
                              );
                            }
                        )
                    )
                  ],
                ),
                const SizedBox(height: 10),
                AnswerSelector(possibleAnswers: possibleAnswers,)
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
                  child: Consumer4<AnswersList, CurrentPoints, QuestionDetails, HintsNotifier>(
                      builder: (context, answersList, currentPoints, questionDetails, hintsNotifier, child) {
                        return FilledButton(
                            onPressed: () {
                              if(answersList.activeId != -1){
                                print("Active Button: ${answersList.activeId}");

                                if(answersList.activeId == correctAnswer){
                                  questionDetails.incrementQuestionNumber();
                                  hintsNotifier.reveal();
                                  currentPoints.setTotalPlusLocal();
                                } else {
                                  print("Wrong Answer!");
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
