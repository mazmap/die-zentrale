import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:quizzly/AnswerSelector.dart';
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

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
            child: Stack(
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
                Container(
                  child: Text("Die Drei Fragezeichen Cover Quiz"),
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: Colors.black,
                              width: 1
                          ),
                      )
                  ),
                )
              ],
            )
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(16),
          child: ListView(
            children: <Widget>[
              Row(
                children: [
                  Expanded(
                    child: Container(
                        color: Colors.black,
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: Text(
                            "Frage 1/200",
                            style: TextStyle(color: Colors.white)
                        )
                    )
                  ),
                  SizedBox(width: 10,),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black)
                    ),
                    child: Text(
                      "157"
                    )
                  )
                ],
              ),
              SizedBox(height: 10,),
              FutureBuilder<ui.Image>(
                  future: _loadImage("assets/covers/folge-001.jpg"),
                  builder: (BuildContext context, AsyncSnapshot<ui.Image> snapshot) {
                    if(snapshot.hasData){
                      return CustomPaint(
                        foregroundPainter: HintsMask(snapshot.data!),
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
                        onPressed: () {  },
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
                        child: Text("Nächster Tip (-2)")
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
              AnswerSelector()
            ],
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          elevation: 0,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical:5),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: Colors.black
                )
              )
            ),
            child: Consumer<AnswersList>(
              builder: (context, answersList, child) {
                return FilledButton(
                    onPressed: () {
                      if(answersList.activeId != -1){
                        print("Active Button: ${answersList.activeId}");
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
                        animationDuration: Duration(milliseconds: 1)
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
