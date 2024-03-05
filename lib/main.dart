import 'package:flutter/material.dart';
import 'package:my_project/lab2/login_page.dart';
import 'package:my_project/lab2/main_page.dart';
import 'package:my_project/lab2/registration_page.dart';
import 'package:my_project/lab2/user_profile_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fitness App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/registration',
      routes: {
        '/': (context) => const MainPage(),
        '/login': (context) => const LoginPage(),
        '/registration': (context) => const RegistrationPage(),
        '/profile': (context) => const UserProfilePage(),
      },
    );
  }
}



