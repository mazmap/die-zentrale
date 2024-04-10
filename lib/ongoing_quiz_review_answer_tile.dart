import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizzly/ongoing_quiz_aq_state.dart';

import 'archive_episode_screen.dart';
import 'episode.dart';
import 'route_transitions/slide_from_right_route.dart';

class OngoingQuizReviewAnswerTile extends StatelessWidget {
  final List<Episode> possibleAnswers;
  final int correctAnswerId;
  final bool isCorrect;

  const OngoingQuizReviewAnswerTile({super.key, required this.possibleAnswers, required this.correctAnswerId, required this.isCorrect});

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];
    for(int i=0; i<possibleAnswers.length; i++){
      if(i == correctAnswerId){
        children.add(Consumer<OngoingQuizAQState>(
          builder: (context, state, child){
            return Material(
              color: (state.isRevealed()) ? (isCorrect) ? Color.fromRGBO(0, 255, 37, 1) : Color.fromRGBO(255, 0, 62, 1) : Colors.white,
              child: InkWell(
                onTap: (){
                  Navigator.push(context, SlideFromRightRoute(page: ArchiveEpisodeScreen(episode: possibleAnswers.elementAt(i))));
                },
                splashFactory: InkSparkle.splashFactory,
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black)
                  ),
                  child: Row(
                    children: [
                      Container(
                          padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 13),
                          decoration: BoxDecoration(
                              border: Border(
                                  right: BorderSide(
                                    color: Colors.black,
                                  )
                              )
                          ),
                          child: Icon(Icons.folder_sharp, size: 18, color: (state.isRevealed()) ? (isCorrect) ? Colors.black : Colors.white : Colors.black,)
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        flex: 1,
                        child: Container(
                          child: Text(
                            possibleAnswers.elementAt(i).title,
                            overflow: TextOverflow.fade,
                            softWrap: false,
                            style: TextStyle(
                                color: (state.isRevealed()) ? (isCorrect) ? Colors.black : Colors.white : Colors.black,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10)
                    ],
                  ),
                ),
              ),
            );
          }
        ));
      } else {
        children.add(Material(
          color: Colors.white,
          child: InkWell(
            onTap: (){
              Navigator.push(context, SlideFromRightRoute(page: ArchiveEpisodeScreen(episode: possibleAnswers.elementAt(i))));
            },
            splashFactory: InkSparkle.splashFactory,
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black)
              ),
              child: Row(
                children: [
                  Container(
                      padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 13),
                      decoration: BoxDecoration(
                          border: Border(
                              right: BorderSide(
                                color: Colors.black,
                              )
                          )
                      ),
                      child: Icon(Icons.folder_sharp, size: 18)
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    flex: 1,
                    child: Container(
                      child: Text(
                        possibleAnswers.elementAt(i).title,
                        overflow: TextOverflow.fade,
                        softWrap: false,
                        style: TextStyle(
                            color: Colors.black
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10)
                ],
              ),
            ),
          ),
        ));
      }
    }

    for(int i=1; i<children.length; i+=2){
      children.insert(i, const SizedBox(height: 5));
    }

    return Column(
      children: children
    );
  }
}
