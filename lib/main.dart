import 'package:flutter/material.dart';
import 'package:quizzly/HomeRoute.dart';
import 'package:quizzly/LoginScreen.dart';
import 'package:quizzly/PlayScreen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://fbpoekhqxmngbnrflqmc.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImZicG9la2hxeG1uZ2JucmZscW1jIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDk3NDkyOTQsImV4cCI6MjAyNTMyNTI5NH0.NmA0qX-6oWagc4S2O9OXJVX4hUbPOyVMv-t_ltYzVTQ',
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
        primarySwatch: Colors.blue,
        fontFamily: "Geist Mono Medium",
      ),
      home: LoginScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}