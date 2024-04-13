import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CoverQuizLeaderboardEntryTile extends StatelessWidget {
  final bool isFirst;
  final String username;
  final int hints;
  final int numberOfAnsweredQuestions;
  final int totalPoints;
  final int place;

  const CoverQuizLeaderboardEntryTile({
    super.key,
    this.isFirst=false,
    required this.username,
    required this.hints,
    required this.numberOfAnsweredQuestions,
    required this.totalPoints,
    this.place = 1
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: (isFirst) ? BoxDecoration(
        color: Colors.black,
      ) : BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black)
      ),
      padding: EdgeInsets.all(10),
      child: Stack(
        children: [
          Skeleton.ignore(
            child: Text(
              "$place.",
                style: TextStyle(
                    color: (isFirst) ? Color.fromRGBO(255, 255, 255, 0.2) : Color.fromRGBO(0, 0, 0, 0.2),
                  fontSize: 48,
                  height: .8,
                  fontWeight: FontWeight.bold
                )
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                username,
                style: TextStyle(
                  color: (isFirst) ? Colors.white : Colors.black
                )
              ),
              IntrinsicHeight(
                child: Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                            "$hints",
                            style: TextStyle(
                                color: (isFirst) ? Colors.white : Colors.black,
                                fontSize: 20,
                                height: .8,
                                fontWeight: FontWeight.bold
                            )
                        ),
                        Text(
                            "$numberOfAnsweredQuestions",
                            style: TextStyle(
                                color: (isFirst) ? Color.fromRGBO(255, 255, 255, 0.75) : Color.fromRGBO(0, 0, 0, 0.5),
                                fontSize: 20,
                                height: .8,
                                fontWeight: FontWeight.bold
                            )
                        )
                      ],
                    ),
                    const SizedBox(width: 5),
                    Text(
                        "$totalPoints",
                        style: TextStyle(
                            color: (isFirst) ? Colors.white : Colors.black,
                            fontSize: 48,
                            height: .8,
                          fontWeight: FontWeight.bold
                        )
                    )
                  ],
                ),
              )
            ]
          )
        ],
      )
    );
  }
}
