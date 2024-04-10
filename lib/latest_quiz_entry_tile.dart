import 'package:flutter/material.dart';

class LatestQuizEntryTile extends StatelessWidget {
  final String username;
  final int hints;
  final int numberOfAnsweredQuestions;
  final int totalPoints;

  const LatestQuizEntryTile({super.key, required this.username, required this.hints, required this.numberOfAnsweredQuestions, required this.totalPoints});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black)
      ),
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children:[
          Text(username),
          Row(
            children: [
              Text(
                  "$numberOfAnsweredQuestions",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  height: .8,
                    color: Color.fromRGBO(0, 0, 0, .5)
                )
              ),
              const SizedBox(width: 10,),
              Text(
                  "$hints",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      height: .8,
                  )
              ),
              const SizedBox(width: 10),
              Text(
                  "$totalPoints",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      height: .8,
                    backgroundColor: Color.fromRGBO(255, 242, 0, 1)
                  )
              )
            ],
          )
        ]
      )
    );
  }
}
