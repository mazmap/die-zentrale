import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quizzly/accept_decline_dialog.dart';
import 'package:quizzly/archive_screen.dart';
import 'package:quizzly/bottom_navigation_button.dart';
import 'package:quizzly/navigate_to_page_button.dart';
import 'package:quizzly/play_screen.dart';
import 'package:quizzly/root_screen.dart';
import 'package:quizzly/simple_text_button.dart';

import 'auth/local_user.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with SingleTickerProviderStateMixin{
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
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Container(
                color: Colors.black,
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                          "@${LocalUser.username}",
                        style: TextStyle(color: Colors.white)
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                      child: Text("?", style: TextStyle(fontVariations: [FontVariation.weight(1000)])),
                    )
                  ]
                )
              ),
              const SizedBox(height: 10),
              Text("Seit dem 31.03.2023 in der Zentrale dabei."),
              const SizedBox(height: 10),
              Expanded(
                child: ListView(
                  children: [
                    NavigateToPageButton(text: "Detektivfarbe ändern"),
                    const SizedBox(height: 10),
                    NavigateToPageButton(text: "Detektivnamen ändern"),
                    const SizedBox(height: 10),
                    NavigateToPageButton(text: "Benutzernamen ändern"),
                    const SizedBox(height: 10),
                    NavigateToPageButton(text: "Passwort ändern"),
                    const SizedBox(height: 40),
                    SimpleTextButton(
                        text: "Ausloggen",
                      onPressed: (){
                        showGeneralDialog(
                            context: context,
                            barrierDismissible: true,
                            barrierLabel: "popup_barrier",
                            pageBuilder: (contextInternal, animation, secondaryAnimation) {
                              return AcceptDeclineDialog(
                                  title: "Achtung",
                                  infoText: "Du bist dabei, dich auszuloggen. Um diese App weiter zu nutzen, musst du dich danach also wieder anmelden. Möchtest du fortfahren?",
                                  acceptText: "Ja",
                                  declineText: "Nein",
                                  onAccept: () async {
                                    await FirebaseAuth.instance.signOut().then((value) => Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>RootScreen()),(route) => false));
                                  },
                                  onDecline: (){}
                              );
                            }
                        );
                      },
                    ),
                    const SizedBox(height: 10),
                    NavigateToPageButton(text: "Gefährliche Operationen")
                  ]
                )
              )
            ]
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
                          activeLock: true,
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
