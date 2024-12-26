import 'package:flutter/material.dart';
import 'package:quizzly/route_transitions/slide_from_right_route.dart';
import 'package:quizzly/screens/archive/archive_episode_screen.dart';

import '../../data/episode.dart';

class ArchiveEpisodeTile extends StatelessWidget {
  final Episode episode;

  const ArchiveEpisodeTile({super.key, required this.episode});

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.card,
      color: Color.fromRGBO(0, 16, 22, 1.0),
      child: InkWell(
        onTap: () {
          Navigator.push(context, SlideFromRightRoute(page: ArchiveEpisodeScreen(episode: episode,)));
        },
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(color: Color.fromRGBO(0, 16, 22, 1.0))
          ),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(10),
                alignment: Alignment.center,
                child: Ink.image(
                  height: 55,
                  width: 55,
                  image: AssetImage(
                    episode.coverAssetPath,
                  ),
                ),
              ),
              Expanded(child: Padding(
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                              episode.title,
                              overflow: TextOverflow.fade,
                              softWrap: false,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontVariations: [FontVariation.weight(200)]
                              )
                          ),
                          Text(
                              episode.releaseDate,
                              style: TextStyle(
                                color: Colors.white,
                              )
                          )
                        ]
                      ),
                    ),
                    SizedBox(width: 10),
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.blue, width: 2),
                      ),
                      padding: EdgeInsets.all(5),
                      alignment: Alignment.center,
                      child: Text(
                          "${episode.number}",
                          style: TextStyle(
                            color: Colors.blue,
                            fontVariations: [
                              FontVariation.weight(200)
                            ]
                          )
                      )
                    )
                  ],
                ),
              ))
            ],
          )
        ),
      ),
    );
  }
}
