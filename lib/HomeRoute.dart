import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quizzly/HomeTile.dart';
import 'package:quizzly/QuizRoute.dart';
import 'package:quizzly/SlideFromRightRoute.dart';

class HomeRoute extends StatefulWidget {
  const HomeRoute({super.key});

  @override
  State<HomeRoute> createState() => _HomeRouteState();
}

class _HomeRouteState extends State<HomeRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(MediaQuery.of(context).viewPadding.top),
        child: Container(
          color: Colors.black,
          height: MediaQuery.of(context).viewPadding.top
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            color: Colors.black,
            padding: const EdgeInsets.only(bottom: 20),
            child: Column(
              children: [
                Image.asset("assets/images/covers.png", width: (MediaQuery.of(context).size.width/4)*3),
                const Text(
                  "Das Drei Fragezeichen Cover Quiz",
                  style: TextStyle(
                    color: Colors. white
                  )
                ),
                const Text(
                  "Folge 1 bis 202",
                  style: TextStyle(
                      color: Colors. white
                  )
                )
              ]
            )
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: ListView(
                children: const [
                  HomeTile(title: "Leaderboard", children: [
                    Center(
                        child: Text("to be continued...")
                    )
                  ]),
                  const SizedBox(height: 20),
                  HomeTile(title: "Mitteilungen", children: [
                    Center(
                        child: Text("to be continued...")
                    )
                  ]),
                  const SizedBox(height: 20),
                  HomeTile(title: "History", children: [
                    Center(
                        child: Text("to be continued...")
                    )
                  ]),
                ],
              ),
            ),
          )
        ]
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
                    Navigator.push(
                      context,
                      SlideFromRightRoute(page: const QuizRoute())
                    );
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
                  child: Text("Neue Runde starten")
              )
          )
      ),
    );
  }
}
