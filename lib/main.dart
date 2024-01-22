import 'package:flutter/material.dart';
import 'package:quiz_app/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz_App',
      theme: ThemeData(
        fontFamily: "ArchitectsDaughter",
        scaffoldBackgroundColor: const Color.fromRGBO(31, 31, 31, 1.0),
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
