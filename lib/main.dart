import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:quizzly/AnswerSelector.dart';
import 'package:quizzly/Coord.dart';
import 'package:quizzly/Episodes.dart';
import 'package:quizzly/HintsMask.dart';

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

Future<ui.Image> _loadImage(String imageAssetPath) async {
  //final bytes = await rootBundle.load(file);
  //Uint8List data = bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes);
  //return decodeImageFromList(data);

  final ByteData data = await rootBundle.load(imageAssetPath);
  final codec = await ui.instantiateImageCodec(
    data.buffer.asUint8List(),
    targetHeight: 350,
    targetWidth: 350,
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
  List<CoordBox> _hintCoords = [];
  final Random _random = Random();

  List<String> leftTitles = [];

  int currentQuestionNumber = 1;

  int correctAnswer = -1;

  List<String> possibleAnswers = [];
  String currentEpCoverPath = "";

  int tipCounter = 0;
  int _tipCost = 1;

  bool _isTipDeactivated = false;

  @override
  void initState() {
    super.initState();
    double x = _random.nextInt(350-40).toDouble();
    double y = _random.nextInt(350-40).toDouble();
    _hintCoords.add(CoordBox(x,y,40));

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
    return ChangeNotifierProvider(
      create: (context) => AnswersList(),
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(40), // Set this height
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
                  width: 50,
                  height: 50,
                  alignment: Alignment.center,
                  child: Text("<-"),
                ),
                Expanded(
                    child: Container(
                        color: Colors.black,
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: Text(
                            "Frage $currentQuestionNumber/200",
                            style: TextStyle(color: Colors.white)
                        )
                    )
                ),
                Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
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
                    child: Text(
                        "0"
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
              FutureBuilder<ui.Image>(
                  future: _loadImage(currentEpCoverPath),
                  builder: (BuildContext context, AsyncSnapshot<ui.Image> snapshot) {
                    if(snapshot.hasData){
                      return CustomPaint(
                        foregroundPainter: HintsMask(snapshot.data!, _hintCoords),
                        child: Container(
                          height: 350,
                          color: Colors.black,
                        )
                        //child: Image.asset("assets/covers/folge-001.jpg")
                      );
                    }
                    return Text("Hallo");
                  }
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: FilledButton(
                        onPressed: _isTipDeactivated ? null : () {
                          int size = 0;
                          bool toggle = false;
                          int newTipCost = 0;
                          if(tipCounter == 0 || tipCounter == 1){
                            size = 40;
                          } else if (tipCounter >=2 && tipCounter <= 4){
                            size = 60;
                          } else if (tipCounter >=5 && tipCounter <=6){
                            size = 80;
                          } else {
                            size = 80;
                            toggle = true;
                          }


                          switch(tipCounter){
                            case 0: newTipCost = 1; break;
                            case 1:
                            case 2:
                            case 3: newTipCost = 2; break;
                            case 4:
                            case 5:
                            case 6: newTipCost = 4; break;
                          }

                          tipCounter++;

                          double x = _random.nextInt(350-size).toDouble();
                          double y = _random.nextInt(350-size).toDouble();

                          setState(() {
                            _hintCoords = [..._hintCoords, CoordBox(x, y, size.toDouble())];
                            _isTipDeactivated = toggle;
                            _tipCost = newTipCost;
                          });
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
                              return ContinuousRectangleBorder();
                            }),
                            animationDuration: Duration(milliseconds: 1),
                            alignment: Alignment.centerLeft,
                          side: MaterialStateProperty.resolveWith((states) {
                            return BorderSide(color: Colors.black);
                          }),
                          padding: MaterialStateProperty.resolveWith((states) {
                            return EdgeInsets.symmetric(horizontal: 20, vertical: 10);
                          })
                        ),
                        child: _isTipDeactivated ? Text("Kein Tip mehr übrig") : Text("Nächster Tip (-$_tipCost)")
                    ),
                  ),
                  SizedBox(width: 10),
                  Container(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black)
                      ),
                      child: Text(
                          "20"
                      )
                  )
                ],
              ),
              SizedBox(height: 10),
              AnswerSelector(possibleAnswers: possibleAnswers,)
            ],
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          elevation: 0,
          height: 70,
          padding: EdgeInsets.zero,
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: Colors.black
                )
              ),
            ),
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Consumer<AnswersList>(
              builder: (context, answersList, child) {
                return FilledButton(
                    onPressed: () {
                      if(answersList.activeId != -1){
                        print("Active Button: ${answersList.activeId}");

                        if(answersList.activeId == correctAnswer){
                          setState(() {
                            currentQuestionNumber = currentQuestionNumber+1;
                          });
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
