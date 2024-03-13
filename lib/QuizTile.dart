import 'package:flutter/material.dart';

import 'SlideFromRightRoute.dart';

class QuizTile extends StatelessWidget {
  final String quizTitle;
  final Widget quizScreen;

  const QuizTile({super.key, required this.quizTitle, required this.quizScreen});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black,
      child: InkWell(
        splashColor: Color.fromRGBO(255, 255, 255, 0.1),
        onTap: (){
          Navigator.push(
              context,
              SlideFromRightRoute(page: quizScreen)
          );
        },
        splashFactory: InkSparkle.splashFactory,
        child: Container(
          padding: const EdgeInsets.only(
            left: 15,
            right: 15,
            bottom: 15,
            top: 75
          ),
          alignment: Alignment.bottomLeft,
          child: Text(quizTitle, style: TextStyle(color: Colors.white))
        ),
      ),
    );
  }
}
