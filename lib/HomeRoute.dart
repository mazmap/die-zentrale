import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quizzly/HomeTile.dart';
import 'package:quizzly/QuizRoute.dart';
import 'package:quizzly/SlideFromRightRoute.dart';

import 'LeaveRoundDialog.dart';

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
          padding: EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top),
          child: Stack(
            children: [
              Container(
                  color: Colors.black,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  alignment: Alignment.center,
                  child: Text(
                      "Quiz",
                      style: const TextStyle(color: Colors.white)
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
                children: [
                  HomeTile(title: "Leaderboard", children: [
                    FutureBuilder(
                      future: FirebaseFirestore.instance.collection("cover_quiz_rounds").limit(10).get(),
                      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot){
                        if(snapshot.hasData){
                          var docs = snapshot.data!.docs;
                          List<Widget> children = [];
                          for(int i=0; i < docs.length; i++){
                            children.add(Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                FutureBuilder(
                                    future: docs.elementAt(i).data()["user"].get(),
                                    builder: (context, AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot){
                                      if(snapshot.hasData){
                                        return Text(snapshot.data!.data()?["username"]);
                                      }
                                      return Text("justusjonas");
                                    }
                                ),
                                Text(docs.elementAt(i).data()["hints_amount"].toString()),
                                Text(docs.elementAt(i).data()["total_points"].toString())
                              ]
                            ));
                          }
                          return Column(
                            children: children,
                          );
                        }
                        return Text("loading...");
                      }
                    )
                  ]),
                  const SizedBox(height: 20),
                  const HomeTile(title: "Mitteilungen", children: [
                    Center(
                        child: Text("to be continued...")
                    )
                  ]),
                  const SizedBox(height: 20),
                  const HomeTile(title: "History", children: [
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
