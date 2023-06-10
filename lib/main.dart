import 'package:flutter/material.dart';
import 'package:quiz_app/screens/home_screen/home_screen.dart';
import 'package:quiz_app/screens/quiz_screen/quiz_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QuizApp',
      home: HomeScreen(),
    );
  }
}
