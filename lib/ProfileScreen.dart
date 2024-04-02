import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:quizzly/ArchiveScreen.dart';
import 'package:quizzly/BottomNavigationButton.dart';
import 'package:quizzly/PlayScreen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(MediaQuery.of(context).viewPadding.top),
        child: Container(color: Colors.white, height: MediaQuery.of(context).viewPadding.top,),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Container(
              color: Colors.black,
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                      "@matteo",
                    style: TextStyle(color: Colors.white)
                  ),
                  Container(
                    color: Colors.white,
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    child: Text("?"),
                  )
                ]
              )
            )
          ]
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
