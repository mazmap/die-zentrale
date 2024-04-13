import 'package:flutter/material.dart';
import 'package:quizzly/screens/play/cover_quiz/ongoing_quiz_answered_question_screen.dart';
import 'package:quizzly/screens/play/cover_quiz/question_details.dart';

import '../../../route_transitions/slide_from_right_route.dart';

class EpisodeQuizSummaryTile extends StatelessWidget {
  final bool isCurrent;

  final QuestionDetails questionDetails;

  const EpisodeQuizSummaryTile({super.key, this.isCurrent = false, required this.questionDetails});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: InkWell(
        onTap: (){
          if(questionDetails.isRevealed){
            Navigator.push(context, SlideFromRightRoute(page: OngoingQuizAnsweredQuestionScreen(questionDetails: questionDetails,)));
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Hier gibt's (noch) nichts zu sehen :)"))
            );
          }
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
          ),
          height: 50,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                          border: Border(
                              right: BorderSide()
                          )
                      ),
                      child: (questionDetails.isRevealed) ? Ink.image(
                          height: 48,
                          width: 48,
                          image: AssetImage(
                            questionDetails.coverAssetPath,
                          )
                      ) : Container(
                        height: 48,
                        width: 48,
                        color: Colors.grey,
                        alignment: Alignment.center,
                        child: Text("?")
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: (questionDetails.isRevealed) ? Text(questionDetails.getCorrectAnswerTitle(), overflow: TextOverflow.fade, softWrap: false,) : Text("?")
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 15),
              Row(
                children: [
                  Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black,
                      ),
                      alignment: Alignment.center,
                      child: Text("${questionDetails.getHintAmount()}", style: TextStyle(color: Colors.white))
                  ),
                  const SizedBox(width: 15),
                  Container(
                    decoration: const BoxDecoration(
                        border: Border(
                            left: BorderSide()
                        )
                    ),
                    width: 50,
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    child: Text("${questionDetails.possiblePoints}"),
                  )
                ],
              )
            ]
          )
        ),
      ),
    );
  }
}
