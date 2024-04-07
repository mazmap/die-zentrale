import 'package:flutter/material.dart';
import 'package:quizzly/LoginScreen.dart';
import 'package:quizzly/NavigateToPageButton.dart';
import 'package:quizzly/RegisterScreen.dart';

class RootScreen extends StatelessWidget {
  const RootScreen({super.key});

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
      padding: EdgeInsets.only(left: 15, right: 15, bottom: 60, top: 15),
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
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                alignment: Alignment.centerLeft,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Die Zentrale", style: TextStyle(color: Colors.white)),
                    Image.asset("assets/icon/ddf_logo.png")
                  ]
                )
              ),
              const SizedBox(height: 10),
              Expanded(
                child: SingleChildScrollView(
                  reverse: true,
                  child: Container(
                    color: Colors.white,
                    padding: EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text("Hallo! Du bist schon Mitglied in der Zentrale? Dann kannst du dich hier einloggen: "),
                        const SizedBox(height: 10),
                        NavigateToPageButton(
                          text: "Zum Login",
                          isPrimary: true,
                          navigateTo: LoginScreen(),
                        ),
                        const SizedBox(height: 20),
                        Text("Wenn du offiziell noch kein Detektiv-Kollege/keine Detektiv-Kollegin bist, dann kannst du dich hier registieren:"),
                        const SizedBox(height: 10),
                        NavigateToPageButton(
                            text: "Zur Registrierung",
                          navigateTo: RegisterScreen(),
                        ),
                      ],
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
