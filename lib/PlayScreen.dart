import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:quizzly/ArchiveScreen.dart';
import 'package:quizzly/BottomNavigationButton.dart';
import 'package:quizzly/CoverQuizHomeScreen.dart';
import 'package:quizzly/QuizTile.dart';
import 'package:quizzly/SimpleTextButton.dart';

import 'ProfileScreen.dart';

class PlayScreen extends StatelessWidget {
  const PlayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(MediaQuery.of(context).viewPadding.top),
        child: Container(color: Colors.white, height: MediaQuery.of(context).viewPadding.top,),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            FutureBuilder<String>(
                future: FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser?.uid).get().then((value) => value.get("username")),
                builder: (context, AsyncSnapshot<String> snapshot){
                  if(snapshot.hasData){
                    return RichText(
                      text: TextSpan(
                          style: DefaultTextStyle.of(context).style,
                        text: "Hallo ",
                        children: [
                          TextSpan(text: "@${snapshot.data}", style: TextStyle(backgroundColor: Color.fromRGBO(255, 242, 0, 1))),
                          TextSpan(text: "! Mal wieder in der Laune einen Highscore zu knacken?")
                        ]
                      ),
                    );
                  } else {
                    return Text("Hallo @justusjonas! Mal wieder in Laune einen Highscore zu knacken?");
                  }
                }
            ),
            const SizedBox(height: 15),
            Expanded(
              child: QuizTile(
                quizTitle: "DAS Drei ??? Cover Quiz",
                quizScreen: CoverQuizHomeScreen(),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: QuizTile(
                quizTitle: "DAS Drei ??? Cover Quiz",
                quizScreen: CoverQuizHomeScreen(),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        height: 50,
        padding: EdgeInsets.zero,
        child: Container(
            decoration: const BoxDecoration(
              border: Border(
                  top: BorderSide(
                      color: Colors.black
                  )
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children:[
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        right: BorderSide()
                      )
                    ),
                    child: BottomNavigationButton(
                      text: "Archiv",
                      navigateTo: ArchiveScreen(),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                      decoration: BoxDecoration(
                          border: Border(
                              right: BorderSide()
                          )
                      ),
                      child: BottomNavigationButton(
                        text: "Spielen",
                        activeLock: true,
                      )
                  ),
                ),
                Expanded(
                  child: Container(
                      decoration: BoxDecoration(
                          border: Border(
                              right: BorderSide()
                          )
                      ),
                      child: BottomNavigationButton(
                        text: "Profil",
                        navigateTo: ProfileScreen(),
                      )
                  ),
                )
              ]
            )
        ) ,
      ),
    );
  }
}
