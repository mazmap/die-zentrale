import 'package:flutter/material.dart';
import 'package:quizzly/AnswerSelector.dart';

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
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        fontFamily: "Geist Mono Medium",
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50), // Set this height
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top),
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
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
                decoration: BoxDecoration(
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
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        padding: EdgeInsets.all(16),
        child: ListView(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
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
            Container(
              height: 350,
              color: Colors.black,
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
                  return ContinuousRectangleBorder(side: BorderSide(color: Colors.black));
                }),
                animationDuration: Duration(milliseconds: 1)
              ),
            child: Text("Antworten")
          )
        )
      )
    );
  }
}
