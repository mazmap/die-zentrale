import 'package:flutter/material.dart';

import 'route_transitions/slide_from_right_route.dart';

class QuizTile extends StatelessWidget {
  final String quizTitle;
  final Widget quizScreen;
  final Widget? quizCover;

  const QuizTile({super.key, required this.quizTitle, required this.quizScreen, this.quizCover});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black,
      child: InkWell(
        splashColor: Color.fromRGBO(255, 255, 255, 0.1),
        onTap: (){
          Navigator.push(
              context,
              SlideFromRightRoute(page: quizScreen, routeSettings: RouteSettings(name: "CoverQuizHome"))
          );
        },
        splashFactory: InkSparkle.splashFactory,
        child: Container(
          padding: const EdgeInsets.only(
            left: 15,
            right: 15,
            bottom: 15,
            top: 15
          ),
          alignment: Alignment.bottomLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              quizCover ?? const SizedBox(height: 100),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(quizTitle, style: const TextStyle(color: Colors.white), textAlign: TextAlign.start,),
              ),
            ],
          )
        ),
      ),
    );
  }
}
