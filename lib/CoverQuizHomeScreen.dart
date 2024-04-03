import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quizzly/CoverQuizDescriptionScreen.dart';
import 'package:quizzly/CoverQuizLeaderboardEntryTile.dart';
import 'package:quizzly/EpisodesService.dart';
import 'package:quizzly/HomeTile.dart';
import 'package:quizzly/CoverQuizScreen.dart';
import 'package:quizzly/InfoPopup.dart';
import 'package:quizzly/LatestQuizEntryTile.dart';
import 'package:quizzly/SlideFromRightRoute.dart';
import 'package:skeletonizer/skeletonizer.dart';

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
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(40),
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
                      "Cover Quiz",
                      style: const TextStyle(color: Colors.white)
                  )
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
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
                  Container(
                    height: 50,
                    child: FilledButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            SlideFromRightRoute(page: const CoverQuizDescriptionScreen())
                        );
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
                      child: const Icon(Icons.info_outlined, size:18),
                    ),
                  ),
                ],
              )
            ],
          )
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                setState(() {});
              },
              color: Colors.black,
              displacement: 15,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
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
                        }).onError((error, stackTrace) {
                          return [{
                            "username": "matteo",
                            "hints_amount": 120,
                            "total_amount": 9999
                          }];
                        }),
                        builder: (BuildContext context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot){
                          List<Widget> children = [];
                          if(snapshot.hasData){
                            children.add(CoverQuizLeaderboardEntryTile(
                                isFirst: true,
                              hints: snapshot.data!.first["hints_amount"],
                              numberOfAnsweredQuestions: snapshot.data!.first["correctly_answered_amount"],
                              totalPoints: snapshot.data!.first["total_points"],
                              username: snapshot.data!.first["username"],
                            ));

                            children.add(const SizedBox(height: 10));
                            for(int i=1; i < snapshot.data!.length; i++){
                              children.add(CoverQuizLeaderboardEntryTile(
                                hints: snapshot.data!.elementAt(i)["hints_amount"],
                                numberOfAnsweredQuestions: snapshot.data!.elementAt(i)["correctly_answered_amount"],
                                totalPoints: snapshot.data!.elementAt(i)["total_points"],
                                username: snapshot.data!.elementAt(i)["username"],
                                place: i+1,
                              ));
                              if(i != snapshot.data!.length-1){
                                children.add(const SizedBox(height: 10));
                              }
                            }
                          } else {
                            children.add(CoverQuizLeaderboardEntryTile(
                              isFirst: true,
                              hints: 120,
                              numberOfAnsweredQuestions: 120,
                              totalPoints: 1000,
                              username: "justusjonas",
                            ));

                            children.add(const SizedBox(height: 10));
                            for(int i=1; i < 5; i++){
                              children.add(CoverQuizLeaderboardEntryTile(
                                hints: 120,
                                numberOfAnsweredQuestions: 120,
                                totalPoints: 1000,
                                username: "justusjonas",
                                place: i+1,
                              ));
                              if(i != 4){
                                children.add(const SizedBox(height: 10));
                              }
                            }
                          }
                          return Skeletonizer(
                            enabled: !snapshot.hasData,
                            child: Column(
                              children: children,
                            ),
                          );
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
                            List<Widget> children = [];
                            if(snapshot.hasData){
                              var docs = snapshot.data!;
                              var currentDoc;
                              for(int i=0; i < docs.length; i++){
                                currentDoc = docs.elementAt(i);
                                children.add(LatestQuizEntryTile(
                                  username: currentDoc["username"],
                                  totalPoints: currentDoc["total_points"],
                                  numberOfAnsweredQuestions: currentDoc["correctly_answered_amount"],
                                  hints: currentDoc["hints_amount"],
                                ));
                                if(i < docs.length-1){
                                  children.add(const SizedBox(height: 10));
                                }
                              }
                            } else {
                              for(int i=0; i < 8; i++){
                                children.add(LatestQuizEntryTile(
                                  username: "justusjonas",
                                  totalPoints: 1000,
                                  numberOfAnsweredQuestions: 29,
                                  hints: 120,
                                ));
                                if(i < 7){
                                  children.add(const SizedBox(height: 10));
                                }
                              }
                            }
                            return Skeletonizer(
                              enabled: !snapshot.hasData,
                              child: Column(
                                children: children,
                              ),
                            );
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
