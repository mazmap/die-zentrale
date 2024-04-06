import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:quizzly/LoginScreen.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Colors.black,
          selectionHandleColor: Colors.black,
          selectionColor: Color.fromRGBO(255, 242, 0, 1)
        ),
        fontFamily: "Geist Mono",
        textTheme: TextTheme(
          bodyMedium: TextStyle(
            fontVariations: [
              FontVariation.weight(100)
            ]
          ),
          labelLarge: TextStyle(
              fontVariations: [
                FontVariation.weight(100)
              ]
          ),
          titleMedium: TextStyle(
              fontVariations: [
                FontVariation.weight(100)
              ]
          ),
          bodyLarge: TextStyle(
        fontVariations: [
        FontVariation.weight(100)
          ]
      )
        ),
        progressIndicatorTheme: ProgressIndicatorThemeData(
          color: Colors.black
        ),
        scaffoldBackgroundColor: Colors.white
      ),
      home: LoginScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}