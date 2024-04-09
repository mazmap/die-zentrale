import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'EpisodesService.dart';
import 'PlayScreen.dart';

class LoginTabView extends StatefulWidget {
  final TabController tabController;

  LoginTabView({super.key, required this.tabController});

  @override
  State<LoginTabView> createState() => _LoginTabViewState();
}

class _LoginTabViewState extends State<LoginTabView> {
  final TextEditingController _usernameController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  String _errorMessage = "";
  String _processMessage = "";

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop){
        FocusScope.of(context).unfocus(disposition: UnfocusDisposition.scope);
        widget.tabController.animateTo(0);
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15, top: 15),
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
                                FocusScope.of(context).unfocus(disposition: UnfocusDisposition.scope);
                                widget.tabController.animateTo(0);
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
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text("Hallo, Kollege/Kollegin! Deine Login-Daten bitte. "),
                          const SizedBox(height: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Benutzername"),
                              TextFormField(
                                validator: (text){
                                  if (text == null || text.isEmpty) {
                                    return "Der Benutzername kann nicht leer sein!";
                                  }
                                  return null;
                                },
                                style: TextStyle(
                                    fontSize: 14
                                ),
                                controller: _usernameController,
                                canRequestFocus: true,
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
                                    filled: true,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Passwort"),
                              TextFormField(
                                style: TextStyle(
                                    fontSize: 14
                                ),
                                validator: (text){
                                  if (text == null || text.isEmpty) {
                                    return "Das Passwort kann nicht leer sein!";
                                  }
                                  return null;
                                },
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
                          const SizedBox(height: 15),
                          Container(
                              child: (_errorMessage.isNotEmpty) ? Text(_errorMessage, style: TextStyle(color: Colors.red[800]),) : null
                          ),
                          Container(
                              child: (_processMessage.isNotEmpty) ? Text(_processMessage, style: TextStyle(color: Colors.black),) : null
                          ),
                          const SizedBox(height: 15),
                          FilledButton(
                              onPressed: () {
                                FocusScope.of(context).unfocus(disposition: UnfocusDisposition.scope);
                                if(_formKey.currentState!.validate()){
                                  setState(() {
                                    _errorMessage = "";
                                    _processMessage = "Anmeldedaten werden überprüft...";
                                  });
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
                                      }).catchError((error){
                                        setState(() {
                                          _errorMessage = "Benutzername oder Passwort ist falsch.";
                                          _processMessage = "";
                                        });
                                      });
                                    } else {
                                      setState(() {
                                        _errorMessage = "Es existiert kein Nutzer mit diesem Benutzernamen.";
                                        _processMessage = "";
                                      });
                                    }
                                  }).onError((error, stacktrace){
                                    setState(() {
                                      _errorMessage = "Internet-Verbindung fehlgeschlagen.";
                                      _processMessage = "";
                                    });
                                  });
                                } else {
                                  setState(() {
                                    _errorMessage = "";
                                    _processMessage = "";
                                  });
                                }
                              },
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(Colors.black),
                                  foregroundColor: MaterialStateProperty.all(Colors.white),
                                  shape: MaterialStateProperty.resolveWith((states) {
                                    return const ContinuousRectangleBorder(side: BorderSide(color: Colors.black));
                                  }),
                                  alignment: Alignment.center,
                                  padding: MaterialStateProperty.resolveWith((states) {
                                    return const EdgeInsets.symmetric(horizontal: 20, vertical: 15);
                                  }),
                                  overlayColor: MaterialStateProperty.all(Color.fromRGBO(255, 255, 255, 0.2))
                              ),
                              child: Text("Login")
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
