import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:quizzly/AnswerSelector.dart';
import 'package:quizzly/Coord.dart';
import 'package:quizzly/CurrentPoints.dart';
import 'package:quizzly/Episodes.dart';
import 'package:quizzly/HintsMask.dart';
import 'package:quizzly/HintsNotifier.dart';
import 'package:quizzly/QuestionDetails.dart';
import 'package:quizzly/TipButton.dart';

import 'AnswersList.dart';

import "dart:ui" as ui;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: "Geist Mono Medium",
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
      debugShowCheckedModeBanner: false,
    );
  }
}

Future<ui.Image> _loadImage(String imageAssetPath, Size? size) async {
  //final bytes = await rootBundle.load(file);
  //Uint8List data = bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes);
  //return decodeImageFromList(data);

  print(size);

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

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
    print(currentEpCoverPath);
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
                    onPressed: () {},
                    child: Icon(Icons.arrow_back, size:18),
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
                        return EdgeInsets.symmetric(horizontal: 5);
                      }),
                      minimumSize: MaterialStateProperty.resolveWith((states) {
                        return Size(10,10);
                      }),
                    ),
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
                        if(snapshot.hasData){
                          double deviceWidth = MediaQuery.of(context).size.width;
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
                        return const Text("Fehler beim Bild Laden!");
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
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                          // If the button is pressed, return green, otherwise blue
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
                          return ContinuousRectangleBorder(side: BorderSide(color: Colors.black));
                        }),
                        animationDuration: Duration(milliseconds: 1),
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
