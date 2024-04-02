import 'dart:math';

import 'package:flutter/material.dart';
import 'package:quizzly/CoverQuizHomeScreen.dart';
import 'package:quizzly/EpisodesService.dart';
import 'package:quizzly/QuizTile.dart';

import 'Episode.dart';
import 'Episodes.dart';

class CoverQuizTile extends StatelessWidget {
  late final String leftCoverPath;
  late final String middleCoverPath;
  late final String rightCoverPath;

  CoverQuizTile({super.key}) {
    Random random = Random();
    List<Episode> episodes = [...Episodes.episodes];
    int l = random.nextInt(episodes.length);
    episodes.removeAt(l);
    int m = random.nextInt(episodes.length);
    episodes.removeAt(m);
    int r = random.nextInt(episodes.length);
    episodes.removeAt(r);

    leftCoverPath = episodes.elementAt(l).coverAssetPath;
    middleCoverPath = episodes.elementAt(m).coverAssetPath;
    rightCoverPath = episodes.elementAt(r).coverAssetPath;
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
