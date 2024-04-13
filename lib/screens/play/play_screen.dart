import 'package:flutter/material.dart';
import 'package:quizzly/screens/archive/archive_screen.dart';
import 'package:quizzly/screens/bottom_navigation_button.dart';
import 'package:quizzly/screens/play/cover_quiz/cover_quiz_tile.dart';

import '../../auth/local_user.dart';
import '../profile/profile_screen.dart';

class PlayScreen extends StatefulWidget {
  const PlayScreen({super.key});

  @override
  State<PlayScreen> createState() => _PlayScreenState();
}

class _PlayScreenState extends State<PlayScreen> with SingleTickerProviderStateMixin {
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
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SlideTransition(
          position: _offsetAnimation,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text.rich(
                TextSpan(
                    text: "Hallo ",
                    children: [
                      TextSpan(text: (LocalUser.isRegistrationComplete) ? LocalUser.detectiveName : "@${LocalUser.username}", style: TextStyle(backgroundColor: Color.fromRGBO(255, 242, 0, 1))),
                      TextSpan(text: "! Mal wieder in der Laune einen Highscore zu knacken?")
                    ]
                )
              ),
              const SizedBox(height: 15),
              Expanded(
                child: ListView(
                  children: [
                    CoverQuizTile(),
                  ],
                ),
              )
            ],
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
                      navigateTo: ArchiveScreen(),
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
                        activeLock: true,
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
