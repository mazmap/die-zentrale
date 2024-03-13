import 'package:flutter/material.dart';
import 'package:quizzly/HomeRoute.dart';
import 'package:quizzly/LoginScreen.dart';
import 'package:quizzly/PlayScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: "Geist Mono Medium",
      ),
      home: LoginScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}