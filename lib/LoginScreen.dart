import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(MediaQuery.of(context).viewPadding.top),
        child: Container(color: Colors.black, height: MediaQuery.of(context).viewPadding.top,),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children:[
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.black,
              alignment: Alignment.center,
              child: Image.asset("assets/images/dreifragezeichen.png", height: 200, width: 200)
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("E-Mail Adresse"),
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
                            hintText: "justus.jonas@gmail.com",
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
                            hintText: "******",
                            fillColor: Colors.white,
                            filled: true,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 50),
                  FilledButton(
                      onPressed: (){},
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
                  const SizedBox(height: 10),
                  FilledButton(
                      onPressed: (){},
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
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
                            return const ContinuousRectangleBorder(side: BorderSide(color: Colors.black));
                          }),
                          animationDuration: const Duration(milliseconds: 1),
                          alignment: Alignment.center,
                          padding: MaterialStateProperty.resolveWith((states) {
                            return const EdgeInsets.symmetric(horizontal: 20, vertical: 15);
                          }),
                          overlayColor: MaterialStateProperty.all(Color.fromRGBO(255, 255, 255, 0.1))
                      ),
                      child: Text("Registieren")
                  )
                ],
              )
            ),
          )
        ]
      )
    );
  }
}
