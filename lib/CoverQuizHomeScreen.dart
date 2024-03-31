import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quizzly/CoverQuizLeaderboardEntryTile.dart';
import 'package:quizzly/HomeTile.dart';
import 'package:quizzly/CoverQuizScreen.dart';
import 'package:quizzly/LatestQuizEntryTile.dart';
import 'package:quizzly/SlideFromRightRoute.dart';

import 'LeaveRoundDialog.dart';

class CoverQuizHomeScreen extends StatefulWidget {
  const CoverQuizHomeScreen({super.key});

  @override
  State<CoverQuizHomeScreen> createState() => _CoverQuizHomeScreenState();
}

class _CoverQuizHomeScreenState extends State<CoverQuizHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color.fromRGBO(250, 244, 237, 1.0),
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
                // Image.asset("assets/images/covers.png", width: (MediaQuery.of(context).size.width/4)*3),
                const Text(
                  "DAS Drei Fragezeichen Cover Quiz",
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
            child: RefreshIndicator(
              onRefresh: () async {
                setState(() {});
              },
              color: Colors.black,
              displacement: 15,
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: ListView(
                  children: [
                    HomeTile(title: "Leaderboard", children: [
                      FutureBuilder<List<Map<String, dynamic>>>(
                        future: FirebaseFirestore.instance.collection("cover_quiz_rounds").orderBy("total_points", descending: true).limit(5).get().then((querySnapshot) async {
                          List<Map<String, dynamic>> leaderBoardEntries = [];
                          for(int i=0; i<querySnapshot.docs.length; i++){
                            leaderBoardEntries.add(
                                await querySnapshot.docs.elementAt(i).data()["user"].get().then((user) {
                                  return {
                                    ...querySnapshot.docs.elementAt(i).data(),
                                    "username": user.data()?["username"]
                                  };
                                })
                            );
                          }
                          return leaderBoardEntries;
                        }),
                        builder: (BuildContext context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot){
                          if(snapshot.hasData){
                            List<Widget> children = [];
                            children.add(CoverQuizLeaderboardEntryTile(
                                isFirst: true,
                              hints: snapshot.data!.first["hints_amount"],
                              numberOfAnsweredQuestions: 120,
                              totalPoints: snapshot.data!.first["total_points"],
                              username: snapshot.data!.first["username"],
                            ));

                            children.add(const SizedBox(height: 10));
                            for(int i=1; i < snapshot.data!.length; i++){
                              children.add(CoverQuizLeaderboardEntryTile(
                                hints: snapshot.data!.elementAt(i)["hints_amount"],
                                numberOfAnsweredQuestions: 120,
                                totalPoints: snapshot.data!.elementAt(i)["total_points"],
                                username: snapshot.data!.elementAt(i)["username"],
                                place: i+1,
                              ));
                              if(i != snapshot.data!.length-1){
                                children.add(const SizedBox(height: 10));
                              }
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
                    HomeTile(title: "Aktuellste Spiele", children: [
                      FutureBuilder<List<Map<String, dynamic>>>(
                          future: FirebaseFirestore.instance.collection("cover_quiz_rounds").orderBy("created_at", descending: true).limit(8).get().then((querySnapshot) async {
                            List<Map<String, dynamic>> latestGamesEntries = [];
                            for(int i=0; i<querySnapshot.docs.length; i++){
                              latestGamesEntries.add(
                                  await querySnapshot.docs.elementAt(i).data()["user"].get().then((user) {
                                    return {
                                      ...querySnapshot.docs.elementAt(i).data(),
                                      "username": user.data()?["username"]
                                    };
                                  })
                              );
                            }
                            return latestGamesEntries;
                          }),
                          builder: (BuildContext context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot){
                            if(snapshot.hasData){
                              var docs = snapshot.data!;
                              List<Widget> children = [];
                              var currentDoc;
                              for(int i=0; i < docs.length; i++){
                                currentDoc = docs.elementAt(i);
                                children.add(LatestQuizEntryTile(
                                  username: currentDoc["username"],
                                  totalPoints: currentDoc["total_points"],
                                  numberOfAnsweredQuestions: 29,
                                  hints: currentDoc["hints_amount"],
                                ));
                                if(i != docs.length-1){
                                  children.add(const SizedBox(height: 10));
                                }
                              }
                              return Column(
                                children: children,
                              );
                            }
                            return Text("loading...");
                          }
                      )
                    ]),
                  ],
                ),
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
                      SlideFromRightRoute(page: const CoverQuizScreen())
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
