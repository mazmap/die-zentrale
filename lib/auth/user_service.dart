import 'dart:ui';

import 'local_user.dart';

class UserService {
  static void initLUWithLoginData({required String email, required String username, required String firebaseUID, required bool isRegistrationComplete}){
    LocalUser.email = email;
    LocalUser.username = username;
    LocalUser.firebaseUID = firebaseUID;
    LocalUser.isRegistrationComplete = isRegistrationComplete;
  }

  static void setRegistrationComplete([bool sync = false]){
    LocalUser.isRegistrationComplete = true;
  }

  static void setDetectiveName(String detectiveName, [bool sync = false]){
    LocalUser.detectiveName = detectiveName;
  }

  static void setDetectiveColorFromColorCode(String colorCode, [bool sync = false]){
    LocalUser.detectiveColor = Color(int.parse(colorCode, radix: 16));
  }

  static Future<void> syncAll() async {
    // sync all parameters to the database (update db values)
  }
}