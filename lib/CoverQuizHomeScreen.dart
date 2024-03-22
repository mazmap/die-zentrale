import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quizzly/HomeTile.dart';
import 'package:quizzly/CoverQuizScreen.dart';
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
                      FutureBuilder(
                        future: FirebaseFirestore.instance.collection("cover_quiz_rounds").orderBy("total_points", descending: true).limit(5).get(),
                        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot){
                          if(snapshot.hasData){
                            var docs = snapshot.data!.docs;
                            List<Widget> children = [];
                            for(int i=0; i < docs.length; i++){
                              children.add(Container(
                                height: 35,
                                decoration: BoxDecoration(
                                    border: Border.all()
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    Row(
                                      children:[
                                        Container(
                                          width: 40,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            border: Border(
                                              right: BorderSide(color: Colors.black)
                                            )
                                          ),
                                          child: Text("${i+1}.")
                                        ),
                                        const SizedBox(width: 10),
                                        FutureBuilder(
                                            future: docs.elementAt(i).data()["user"].get(),
                                            builder: (context, AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot){
                                              if(snapshot.hasData){
                                                return Text(snapshot.data!.data()?["username"]);
                                              }
                                              return Text("justusjonas");
                                            }
                                        )
                                      ]
                                    ),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                      children:[
                                        Container(
                                            width: 60,
                                            decoration: BoxDecoration(
                                              border: Border(
                                                left: BorderSide(color: Colors.black)
                                              )
                                            ),
                                            alignment: Alignment.centerRight,
                                            padding: EdgeInsets.symmetric(horizontal: 10),
                                            child: Text(docs.elementAt(i).data()["hints_amount"].toString())
                                        ),
                                        Container(
                                          width: 60,
                                            decoration: BoxDecoration(
                                                border: Border(
                                                    left: BorderSide(color: Colors.black)
                                                )
                                            ),
                                            alignment: Alignment.centerRight,
                                            padding: EdgeInsets.symmetric(horizontal: 10),
                                            child: Text(docs.elementAt(i).data()["total_points"].toString())
                                        )
                                      ]
                                    )
                                  ]
                                ),
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
                    const SizedBox(height: 20),
                    HomeTile(title: "Aktuellste Spiele", children: [
                      FutureBuilder(
                          future: FirebaseFirestore.instance.collection("cover_quiz_rounds").orderBy("created_at", descending: true).limit(8).get(),
                          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot){
                            if(snapshot.hasData){
                              var docs = snapshot.data!.docs;
                              List<Widget> children = [];
                              var currentDoc;
                              for(int i=0; i < docs.length; i++){
                                currentDoc = docs.elementAt(i);
                                children.add(Container(
                                  height: 35,
                                  decoration: BoxDecoration(
                                      border: Border.all()
                                  ),
                                  child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              width: 55,
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                    border: Border(
                                                        right: BorderSide(color: Colors.black)
                                                    )
                                                ),
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                  children:[
                                                    Text("${currentDoc.get("created_at").toDate().day}.${currentDoc.get("created_at").toDate().month}", style: TextStyle(height: 0.85)),
                                                    Text("${currentDoc.get("created_at").toDate().hour}:${currentDoc.get("created_at").toDate().minute}", style: TextStyle(height: 0.95)),
                                                  ]
                                                )
                                            ),
                                            Container(
                                              alignment: Alignment.centerLeft,
                                              padding: EdgeInsets.only(left: 10),
                                              child: FutureBuilder(
                                                  future: docs.elementAt(i).data()["user"].get(),
                                                  builder: (context, AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot){
                                                    if(snapshot.hasData){
                                                      return Text(snapshot.data!.data()?["username"]);
                                                    }
                                                    return Text("justusjonas");
                                                  }
                                              ),
                                            ),
                                          ]
                                        ),
                                        Row(
                                            crossAxisAlignment: CrossAxisAlignment.stretch,
                                            children:[
                                              Container(
                                                  width: 60,
                                                  decoration: BoxDecoration(
                                                      border: Border(
                                                          left: BorderSide(color: Colors.black)
                                                      )
                                                  ),
                                                  alignment: Alignment.centerRight,
                                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                                  child: Text(docs.elementAt(i).data()["hints_amount"].toString())
                                              ),
                                              Container(
                                                  width: 60,
                                                  decoration: BoxDecoration(
                                                      border: Border(
                                                          left: BorderSide(color: Colors.black)
                                                      )
                                                  ),
                                                  alignment: Alignment.centerRight,
                                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                                  child: Text(docs.elementAt(i).data()["total_points"].toString())
                                              )
                                            ]
                                        )
                                      ]
                                  ),
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
