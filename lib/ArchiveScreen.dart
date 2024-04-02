import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:quizzly/ArchiveEpisodeTile.dart';
import 'package:quizzly/BottomNavigationButton.dart';
import 'package:quizzly/EpisodesService.dart';
import 'package:quizzly/PlayScreen.dart';
import 'package:quizzly/ProfileScreen.dart';

import 'Episodes.dart';

class ArchiveScreen extends StatefulWidget {
  const ArchiveScreen({super.key});

  @override
  State<ArchiveScreen> createState() => _ArchiveScreenState();
}

class _ArchiveScreenState extends State<ArchiveScreen> with SingleTickerProviderStateMixin{
  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 150),
    vsync: this,
  )..animateTo(1);
  late final Animation<Offset> _offsetAnimation = Tween<Offset>(
    begin: const Offset(0.0, 1.0),
    end: Offset.zero,
  ).animate(CurvedAnimation(
      curve: Curves.easeOutQuart,
      parent: _controller
  ));

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(MediaQuery.of(context).viewPadding.top),
          child: Container(color: Colors.white, height: MediaQuery.of(context).viewPadding.top,),
        ),
      body: SlideTransition(
        position: _offsetAnimation,
        child: Padding(
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
