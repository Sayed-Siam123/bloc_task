import 'package:bloc_task/presentations/screens/home_screen.dart';
import 'package:flutter/material.dart';

class AppRouter {

  Route? onGeneratedRoute(RouteSettings? route) {
    switch (route!.name) {
      case '/':
        return MaterialPageRoute(
              builder: (_) => const HomeScreen(),
        );
      default:
        return null;
    }
  }
}