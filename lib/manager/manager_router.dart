import 'package:flutter/material.dart';
import 'package:quiz_app/screens/home_screen/home_screen.dart';

class ManagerRoutes {
  ManagerRoutes._();
  static String homeScreen = '/home_screen';

  static Map<String, Widget Function(BuildContext)> manager = {
    homeScreen: (context) => const HomeScreen(),
  };
}
