import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quizzly/auth/user_service.dart';
import 'package:quizzly/screens/boarding/complete_registration_screen.dart';
import 'package:quizzly/screens/boarding/root_screen.dart';
import 'package:quizzly/screens/loading/loading_screen.dart';
import 'package:quizzly/screens/play/play_screen.dart';

import '../../auth/local_user.dart';
import '../../data/episodes_service.dart';

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
              if(userData["isRegistrationComplete"]){
                UserService.setDetectiveName(userData["detectiveName"]);
                UserService.setDetectiveColorFromColorCode(userData["detectiveColor"]);
              }
            });
            return LocalUser.isRegistrationComplete;
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
              return const CompleteRegistrationScreen(startOnMessage: true,);
            }
        },
      );
    } else {
      return RootScreen();
    }
  }
}
