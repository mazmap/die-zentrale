import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:quizzly/ArchiveEpisodeTile.dart';
import 'package:quizzly/BottomNavigationButton.dart';
import 'package:quizzly/EpisodesService.dart';
import 'package:quizzly/PlayScreen.dart';
import 'package:quizzly/ProfileScreen.dart';

import 'Episodes.dart';

class ArchiveScreen extends StatelessWidget {
  const ArchiveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 15),
        child: CupertinoScrollbar(
          radius: Radius.zero,
          radiusWhileDragging: Radius.zero,
          child: Padding(
            padding: EdgeInsets.only(left: 15, right: 15, bottom: 15),
            child: ListView.separated(
              itemCount: EpisodesService.getEpisodesAmount(),
                addAutomaticKeepAlives: true,
                separatorBuilder: (context, index) {
                  return const SizedBox(height: 10);
                },
                itemBuilder: (context, index) {
                  return ArchiveEpisodeTile(episode: EpisodesService.getNthEpisode(index));
                }
            )

          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        height: 50,
        padding: EdgeInsets.zero,
        child: Container(
            decoration: const BoxDecoration(
              border: Border(
                  top: BorderSide(
                      color: Colors.black
                  )
              ),
            ),
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children:[
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border(
                              right: BorderSide()
                          )
                      ),
                      child: BottomNavigationButton(
                        text: "Archiv",
                        activeLock: true,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                        decoration: BoxDecoration(
                            border: Border(
                                right: BorderSide()
                            )
                        ),
                        child: BottomNavigationButton(
                          text: "Spielen",
                          navigateTo: PlayScreen(),
                        )
                    ),
                  ),
                  Expanded(
                    child: Container(
                        decoration: BoxDecoration(
                            border: Border(
                                right: BorderSide()
                            )
                        ),
                        child: BottomNavigationButton(
                          text: "Profil",
                          navigateTo: ProfileScreen(),
                        )
                    ),
                  )
                ]
            )
        ) ,
      ),
    );
  }
}
