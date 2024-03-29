import 'package:flutter/material.dart';
import 'package:my_project/lab2/elements/app_routes.dart';

import 'package:my_project/lab2/pages/splash_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fitness App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(),
      routes: appRoutes,
    );
  }
}
