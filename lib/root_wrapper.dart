import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quizzly/auth/user_service.dart';
import 'package:quizzly/complete_registration_screen.dart';
import 'package:quizzly/loading_screen.dart';
import 'package:quizzly/play_screen.dart';
import 'package:quizzly/root_screen.dart';

import 'auth/local_user.dart';
import 'episodes_service.dart';

class RootWrapper extends StatelessWidget {
  final User? firebaseUser = FirebaseAuth.instance.currentUser;
  late final bool isLoggedIn;

  RootWrapper({super.key}){
    isLoggedIn = (firebaseUser != null);
  }

  @override
  Widget build(BuildContext context) {
    if(isLoggedIn){
      // load loading screen to load user data to init LocalUser
      return LoadingScreen<bool>(
          waitFor: (displayMessage, displayErrorMessage) async {
            displayMessage("Lade Benutzerdaten");
            await FirebaseFirestore.instance.collection("users").where("email", isEqualTo: firebaseUser!.email).limit(1).get().then((res){
              Map<String, dynamic> userData = res.docs.elementAt(0).data();
              UserService.initLUWithLoginData(
                  email: userData["email"],
                  username: userData["username"],
                  firebaseUID: firebaseUser!.uid,
                  isRegistrationComplete: userData["isRegistrationComplete"]
              );
            });
            return LocalUser.isRegistrationComplete;

            // TODO: load after completed registration
            displayMessage("Lade die neusten Episoden");
            await EpisodesService.loadEpisodes();
          },
        navigateTo: (isRegistrationComplete){
            if(isRegistrationComplete){
              return LoadingScreen(
                waitFor: (displayMessage, displayErrorMessage) async {
                  try{
                    displayMessage("Lade Episoden...");
                    await EpisodesService.loadEpisodes();
                  } catch (e) {
                    displayErrorMessage("Keine Internetverbindung!");
                  }
                },
                navigateTo: (res)=>const PlayScreen(),
              );
            } else {
              return const CompleteRegistrationScreen();
            }
        },
      );
    } else {
      return RootScreen();
    }
  }
}
