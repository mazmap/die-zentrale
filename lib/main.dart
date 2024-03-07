import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:quizzly/AnswerSelector.dart';
import 'package:quizzly/Coord.dart';
import 'package:quizzly/CurrentPoints.dart';
import 'package:quizzly/Episodes.dart';
import 'package:quizzly/HintsMask.dart';
import 'package:quizzly/HintsNotifier.dart';
import 'package:quizzly/HomeRoute.dart';
import 'package:quizzly/QuestionDetails.dart';
import 'package:quizzly/TipButton.dart';

import 'AnswersList.dart';

import "dart:ui" as ui;

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
      home: const HomeRoute(),
      debugShowCheckedModeBanner: false,
    );
  }
}