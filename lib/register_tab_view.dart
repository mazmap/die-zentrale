import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quizzly/extensions/string_validator.dart';

import 'episodes_service.dart';
import 'loading_screen.dart';

class RegisterTabView extends StatefulWidget {
  final TabController tabController;

  RegisterTabView({super.key, required this.tabController});

  @override
  State<RegisterTabView> createState() => _RegisterTabViewState();
}

class _RegisterTabViewState extends State<RegisterTabView> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _passwordConfirmController = TextEditingController();

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
                      Text("Registrierung", style: TextStyle(color: Colors.white)),
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
                          Text("Prima, du möchtest also der Zentrale beitreten. Denk dir dafür ersteinmal einen tollen Benutzernamen und ein sicheres Passwort aus."),
                          const SizedBox(height: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Email-Adresse"),
                              TextFormField(
                                style: TextStyle(
                                    fontSize: 14
                                ),
                                validator: (text){
                                  if(!(text?.isValidEmail ?? false)){
                                    return "Gib eine richtige Email-Adresse an.";
                                  }
                                  return null;
                                },
                                controller: _emailController,
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
                                    hintText: "justus.jonas@gmail.com",
                                    fillColor: Colors.white,
                                    filled: true,
                                  errorMaxLines: 10,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Benutzername"),
                              TextFormField(
                                style: TextStyle(
                                    fontSize: 14
                                ),
                                validator: (text){
                                  if(!(text?.isAtLeast3Long ?? false)){
                                    return "Der Benutzername muss mindestens 3 Zeichen lang sein.";
                                  } else if(!(text?.isMax20Long ?? false)){
                                    return "Der Benutzername darf maximal 20 Zeichen lang sein.";
                                  } else if(!(text?.isValidUsername ?? false)){
                                    return "Der Benutzername darf nur Klein- und Großbuchstaben, sowie die Zeichen _ . und ? enthalten.";
                                  }
                                  return null;
                                },
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
                                    filled: true,
                                  errorMaxLines: 10,
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
                                  if(text != null && text.isEmpty){
                                    return "Das Passwort darf nicht leer sein.";
                                  } else if(!(text?.isAtLeastNLong(6) ?? false)){
                                    return "Das Passwort muss mindestens 6 Zeichen lang sein.";
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
                                  errorMaxLines: 10,
                                ),
                                obscureText: true,
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Passwort wiederholen"),
                              TextFormField(
                                style: TextStyle(
                                    fontSize: 14
                                ),
                                validator: (text) {
                                  if(_passwordController.text != text){
                                    return "Die Passwörter stimmen nicht überein.";
                                  }
                                  return null;
                                },
                                controller: _passwordConfirmController,
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
                                  errorMaxLines: 10,
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
                              onPressed: () async {
                                FocusScope.of(context).unfocus(disposition: UnfocusDisposition.scope);
                                if(_formKey.currentState!.validate()){
                                  setState(() {
                                    _errorMessage = "";
                                    _processMessage = "Registriere neuen Nutzer...";
                                  });
                                  FirebaseFirestore.instance.collection("users").where("email", isEqualTo: _emailController.text).limit(1).get().then((data) async {
                                    if(data.docs.length == 1){
                                      setState(() {
                                        _errorMessage = "Es existiert bereits ein Account zu dieser Email-Adresse.";
                                        _processMessage = "";
                                      });
                                    } else {
                                      await FirebaseFirestore.instance.collection("users").where("username", isEqualTo: _usernameController.text).limit(1).get().then((data) async {
                                        if(data.docs.length == 1){
                                          setState(() {
                                            _errorMessage = "Es existiert bereits ein Account mit diesem Benutzernamen.";
                                            _processMessage = "";
                                          });
                                        } else {
                                          try{
                                            UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                                                email: _emailController.text,
                                                password: _passwordController.text
                                            );
                                            await FirebaseFirestore.instance.collection("users").doc(userCredential.user?.uid).set({
                                              "email": _emailController.text,
                                              "username": _usernameController.text
                                            });
                                            setState(() {
                                              _errorMessage = "";
                                              _processMessage = "Erfolgreich registriert!";
                                            });
                                            Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(builder: (context) => LoadingScreen(
                                                  waitFor: (displayMessage, displayErrorMessage) async {
                                                    try{
                                                      displayMessage("Lade Episoden...");
                                                      await EpisodesService.loadEpisodes();
                                                    } on FirebaseException catch (e) {
                                                      if(e.code == "network-request-failed"){
                                                        displayErrorMessage("Keine Internetverbindung!");
                                                      }
                                                    }
                                                  },
                                                ))
                                            );
                                          } on FirebaseAuthException catch(e) {
                                            if(e.code == "email-already-in-use"){
                                              setState(() {
                                                _errorMessage = "Es existiert bereits ein Account zu dieser Email-Adresse.";
                                                _processMessage = "";
                                              });
                                            } else if(e.code == "network-request-failed"){
                                              setState(() {
                                                _errorMessage = "Internetverbindung fehlgeschlagen. Für die Registrierung wird ein Internetzugang benötigt.";
                                                _processMessage = "";
                                              });
                                            } else {
                                              setState(() {
                                                _errorMessage = "Ein Fehler ist aufgetreten";
                                                _processMessage = "";
                                              });
                                            }
                                          }
                                        }
                                      }).catchError((error){
                                        if(error.code == "network-request-failed"){
                                          setState(() {
                                            _errorMessage = "Internetverbindung fehlgeschlagen.";
                                            _processMessage = "";
                                          });
                                        }
                                      });
                                    }
                                  });
                                }
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
                              child: Text("Registrieren")
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
