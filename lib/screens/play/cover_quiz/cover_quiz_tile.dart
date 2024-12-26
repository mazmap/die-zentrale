import 'dart:math';

import 'package:flutter/material.dart';
import 'package:quizzly/screens/play/cover_quiz/cover_quiz_home_screen.dart';
import 'package:quizzly/screens/play/quiz_tile.dart';

import '../../../data/episode.dart';
import '../../../data/episodes.dart';

class CoverQuizTile extends StatelessWidget {
  late final String leftCoverPath;
  late final String middleCoverPath;
  late final String rightCoverPath;

  CoverQuizTile({super.key}) {
    Random random = Random();
    List<Episode> episodes = [...Episodes.episodes];
    int l = random.nextInt(episodes.length);
    leftCoverPath = episodes.elementAt(l).coverAssetPath;
    episodes.removeAt(l);
    int m = random.nextInt(episodes.length);
    middleCoverPath = episodes.elementAt(m).coverAssetPath;
    episodes.removeAt(m);
    int r = random.nextInt(episodes.length);
    rightCoverPath = episodes.elementAt(r).coverAssetPath;
    episodes.removeAt(r);
  }

  @override
  Widget build(BuildContext context) {
    return QuizTile(
        quizTitle: "DAS Drei ??? Cover Quiz",
        quizScreen: const CoverQuizHomeScreen(),
      quizCover: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Ink(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    image: DecorationImage(
                        image: AssetImage(leftCoverPath)
                    ),
                    border: Border.all(color: Colors.white),
                      boxShadow: const [
                        BoxShadow(
                            color: Color.fromRGBO(255, 255, 255, .2),
                            blurRadius: 10,
                            spreadRadius: 4
                        )
                      ]
                  ),
                ),
                Ink(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      image: DecorationImage(
                          image: AssetImage(rightCoverPath)
                      ),
                      border: Border.all(color: Colors.white),
                      boxShadow: const [
                        BoxShadow(
                            color: Color.fromRGBO(255, 255, 255, .5),
                            blurRadius: 10,
                            spreadRadius: 4
                        )
                      ]
                  ),
                ),
              ],
            ),
            Ink(
              height: 125,
              width: 125,
              decoration: BoxDecoration(
                  color: Colors.white,
                image: DecorationImage(
                  image: AssetImage(middleCoverPath)
                ),
                border: Border.all(color: Colors.white),
                boxShadow: const [
                  BoxShadow(
                      color: Color.fromRGBO(255, 255, 255, .5),
                      blurRadius: 10,
                      spreadRadius: 4
                  )
                ]
              ),
            )
          ],
        ),
      ),
    );
  }
}
