import 'package:flutter/material.dart';
import 'package:quiz_app/screens/detail_screen/detail_screen.dart';
import 'package:quiz_app/screens/home_screen/home_screen.dart';
import 'package:quiz_app/screens/quiz_screen/quiz_screen.dart';

class ManagerRoutes {
  ManagerRoutes._();
  static String homeScreen = '/home_screen';
  static String detailScreen = '/detail_screen';
  static String quizScreen = '/quiz_screen';

  static Map<String, Widget Function(BuildContext)> manager = {
    homeScreen: (context) => const HomeScreen(),
    detailScreen: (context) => const DetailScreen(),
    quizScreen: (context) => const QuizScreen(),
  };
}
