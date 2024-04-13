import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quizzly/episodes_service.dart';
import 'package:quizzly/screens/play/play_screen.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.black,
        image: DecorationImage(
            image: AssetImage("assets/images/episodes-grid.png"),
            fit: BoxFit.fill,
            opacity: .75
        ),
      ),
      padding: EdgeInsets.only(left: 15, right: 15, bottom: 15, top: 15),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                  height: 50,
                  color: Colors.black,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Text("Login", style: TextStyle(color: Colors.white)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            height: 50,
                            child: FilledButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              style: ButtonStyle(
                                alignment: Alignment.center,
                                backgroundColor: MaterialStateProperty.resolveWith((states) {
                                  return Colors.black;
                                }),
                                iconColor: MaterialStateProperty.resolveWith((states) {
                                  return Colors.white;
                                }),
                                padding: MaterialStateProperty.resolveWith((states) {
                                  return const EdgeInsets.symmetric(horizontal: 15);
                                }),
                                minimumSize: MaterialStateProperty.resolveWith((states) {
                                  return const Size(10,10);
                                }),
                              ),
                              child: const Icon(Icons.arrow_back, size:18),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                            child: Image.asset("assets/icon/ddf_logo.png"),
                          )
                        ],
                      ),
                    ]
                  )
              ),
              const SizedBox(height: 15),
              Expanded(
                child: CupertinoScrollbar(
                  child: SingleChildScrollView(
                    reverse: true,
                    child: Container(
                      color: Colors.white,
                      padding: EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text("Hallo, Kollege/Kollegin! Deine Login-Daten bitte. "),
                          const SizedBox(height: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Benutzername"),
                              TextField(
                                style: TextStyle(
                                    fontSize: 14
                                ),
                                controller: _usernameController,
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(borderRadius: BorderRadius.zero, borderSide: BorderSide(color: Colors.black)),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.zero,
                                        borderSide: BorderSide(color: Colors.black)
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.zero,
                                        borderSide: BorderSide(color: Colors.black)
                                    ),
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 15,
                                        horizontal: 20
                                    ),
                                    hintText: "justusjonas",
                                    fillColor: Colors.white,
                                    filled: true
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Passwort"),
                              TextField(
                                style: TextStyle(
                                    fontSize: 14
                                ),
                                controller: _passwordController,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(borderRadius: BorderRadius.zero, borderSide: BorderSide(color: Colors.black)),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.zero,
                                      borderSide: BorderSide(color: Colors.black)
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.zero,
                                      borderSide: BorderSide(color: Colors.black)
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 15,
                                      horizontal: 20
                                  ),
                                  hintText: "******",
                                  fillColor: Colors.white,
                                  filled: true,
                                ),
                                obscureText: true,
                              ),
                            ],
                          ),
                          const SizedBox(height: 30),
                          FilledButton(
                              onPressed: () {
                                FirebaseFirestore.instance.collection("users").where("username", isEqualTo: _usernameController.value.text).get().then((value) {
                                  if(value.docs.isNotEmpty){
                                    FirebaseAuth.instance.signInWithEmailAndPassword(email: value.docs.elementAt(0).data()["email"] ?? "", password: _passwordController.value.text).then((value) {
                                      User? user = value.user;
                                      EpisodesService.loadEpisodes().then((value){
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(builder: (context) => PlayScreen())
                                        );
                                      });
                                    });
                                  }
                                });
                              },
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
                                    if (states.contains(MaterialState.pressed)) {
                                      return Colors.white;
                                    }
                                    return Colors.black;
                                  }),
                                  foregroundColor: MaterialStateProperty.resolveWith((states) {
                                    if (states.contains(MaterialState.pressed)) {
                                      return Colors.black;
                                    }
                                    return Colors.white;
                                  }),
                                  shape: MaterialStateProperty.resolveWith((states) {
                                    return const ContinuousRectangleBorder(side: BorderSide(color: Colors.black));
                                  }),
                                  animationDuration: const Duration(milliseconds: 1),
                                  alignment: Alignment.center,
                                  padding: MaterialStateProperty.resolveWith((states) {
                                    return const EdgeInsets.symmetric(horizontal: 20, vertical: 15);
                                  }),
                                  overlayColor: MaterialStateProperty.all(Color.fromRGBO(0, 0, 0, 0.1))
                              ),
                              child: Text("Login")
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
