import 'package:flutter/material.dart';
import 'package:quizzly/archive_episode_screen.dart';
import 'package:quizzly/route_transitions/slide_from_right_route.dart';

import 'episode.dart';

class ArchiveEpisodeTile extends StatelessWidget {
  final Episode episode;

  const ArchiveEpisodeTile({super.key, required this.episode});

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.card,
      color: Colors.white,
      child: InkWell(
        splashColor: Color.fromRGBO(0, 0, 0, 0.2),
        onTap: () {
          Navigator.push(context, SlideFromRightRoute(page: ArchiveEpisodeScreen(episode: episode,)));
        },
        child: Container(
          decoration: BoxDecoration(
              border: Border.all()
          ),
          height: 75,
          child: Row(
            children: [
              Container(
                decoration: const BoxDecoration(
                    border: Border(
                        right: BorderSide()
                    ),
                ),
                child: Ink.image(
                  height: 73,
                  width: 73,
                  image: AssetImage(
                    episode.coverAssetPath,
                  ),
                ),
              ),
              Expanded(child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                              child: Text(
                                episode.title,
                                overflow: TextOverflow.fade,
                                softWrap: false,
                                style: TextStyle(fontVariations: [FontVariation.weight(200)])
                              )
                          ),
                          SizedBox(width: 5),
                          Text("(${episode.number})")
                        ]
                    ),
                    Text(episode.releaseDate)
                  ]
                ),
              ))
            ],
          )
        ),
      ),
    );
  }
}
