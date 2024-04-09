import 'dart:ui';

class LocalUser{
  String email;
  String username;
  String firebaseUID;
  late String detectiveName;
  late Color detectiveColor;

  bool isRegistrationComplete = false;

  LocalUser({required this.email, required this.username, required this.firebaseUID});

  void setRegistrationComplete([bool sync = false]){
    isRegistrationComplete = true;
  }

  void setDetectiveName(String detectiveName, [bool sync = false]){
    this.detectiveName = detectiveName;
  }

  void setDetectiveColorFromColorCode(String colorCode, [bool sync = false]){
    detectiveColor = Color(int.parse(colorCode, radix: 16));
  }

  Future<void> syncAll() async {
    // sync all parameters to the database (update db values)
  }
}