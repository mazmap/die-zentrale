import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:quizzly/ArchiveScreen.dart';
import 'package:quizzly/PlayScreen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      child: FilledButton(
                          onPressed: () {
                            Navigator.pushReplacement(context, PageRouteBuilder(pageBuilder: (_, __, ___) => ArchiveScreen()));
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.resolveWith((states) {
                              if (states.contains(MaterialState.pressed)) {
                                return Colors.black;
                              }
                              return Colors.white;
                            }),
                            foregroundColor: MaterialStateProperty.resolveWith((states) {
                              if (states.contains(MaterialState.pressed)) {
                                return Colors.white;
                              }
                              return Colors.black;
                            }),
                            shape: MaterialStateProperty.resolveWith((states) {
                              return const ContinuousRectangleBorder();
                            }),
                            animationDuration: const Duration(milliseconds: 1),
                            fixedSize: MaterialStateProperty.resolveWith((states) {
                              return Size(0, 50);
                            }),
                          ),
                          child: Text("Archiv")
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
                        child: FilledButton(
                            onPressed: () {
                              Navigator.pushReplacement(context, PageRouteBuilder(pageBuilder: (_, __, ___) => PlayScreen()),);
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.resolveWith((states) {
                                if (states.contains(MaterialState.pressed)) {
                                  return Colors.black;
                                }
                                return Colors.white;
                              }),
                              foregroundColor: MaterialStateProperty.resolveWith((states) {
                                if (states.contains(MaterialState.pressed)) {
                                  return Colors.white;
                                }
                                return Colors.black;
                              }),
                              shape: MaterialStateProperty.resolveWith((states) {
                                return const ContinuousRectangleBorder();
                              }),
                              animationDuration: const Duration(milliseconds: 1),
                              fixedSize: MaterialStateProperty.resolveWith((states) {
                                return Size(0, 50);
                              }),
                            ),
                            child: Text("Spielen")
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
                        child: FilledButton(
                            onPressed: () {
                              // ABSICHTLICH LEER
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.resolveWith((states) {
                                return Colors.black;
                              }),
                              foregroundColor: MaterialStateProperty.resolveWith((states) {
                                return Colors.white;
                              }),
                              shape: MaterialStateProperty.resolveWith((states) {
                                return const ContinuousRectangleBorder();
                              }),
                              animationDuration: const Duration(milliseconds: 1),
                              fixedSize: MaterialStateProperty.resolveWith((states) {
                                return Size(0, 50);
                              }),
                            ),
                            child: Text("Profil")
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
