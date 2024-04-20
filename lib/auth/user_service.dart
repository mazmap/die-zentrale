import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quizzly/auth/user_data_field.dart';

import 'local_user.dart';

class UserService {
  static void initLUWithLoginData({required String email, required String username, required String firebaseUID, required bool isRegistrationComplete}){
    LocalUser.email = email;
    LocalUser.username = username;
    LocalUser.firebaseUID = firebaseUID;
    LocalUser.isRegistrationComplete = isRegistrationComplete;
  }

  static Future<void> setRegistrationComplete([bool sync = false]) async {
    LocalUser.isRegistrationComplete = true;
  }

  static Future<void> setDetectiveName(String detectiveName, [bool sync = false]) async {
    LocalUser.detectiveName = detectiveName;
  }

  static Future<void> setDetectiveColorFromColorCode(int colorCode, [bool sync = false]) async {
    LocalUser.detectiveColor = Color(colorCode).withAlpha(255);
  }

  static Future<void> syncAll() async {
    // sync all parameters to the database (update db values)
  }

  static Future<void> syncOnly(List<UserDataField> userDataFields, Function(FirebaseException error) onError) async {
    Map<String, dynamic> newUserData = {};

    if(userDataFields.contains(UserDataField.username)){
      newUserData["username"] = LocalUser.username;
    }
    if(userDataFields.contains(UserDataField.detectiveName)) {
      newUserData["detectiveName"] = LocalUser.detectiveName;
    }
    if(userDataFields.contains(UserDataField.detectiveColor)) {
      newUserData["detectiveColor"] = LocalUser.detectiveColor.value;
    }
    if(userDataFields.contains(UserDataField.isRegistrationComplete)){
      newUserData["isRegistrationComplete"] = LocalUser.isRegistrationComplete;
    }
    if(userDataFields.contains(UserDataField.email)) {
      newUserData["email"] = LocalUser.email;
      try{
        await FirebaseAuth.instance.currentUser?.verifyBeforeUpdateEmail(LocalUser.email);
        await FirebaseFirestore.instance.collection("users").doc(LocalUser.firebaseUID).update(newUserData);
      } on FirebaseException catch (e) {
        onError(e);
        return;
      }
    }

    try{
      await FirebaseFirestore.instance.collection("users").doc(LocalUser.firebaseUID).update(newUserData);
    } on FirebaseException catch (e) {
      onError(e);
    }
  }
}