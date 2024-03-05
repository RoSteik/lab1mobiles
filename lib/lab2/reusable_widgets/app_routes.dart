import 'package:flutter/material.dart';
import 'package:my_project/lab2/login_page.dart';
import 'package:my_project/lab2/main_page.dart';
import 'package:my_project/lab2/registration_page.dart';
import 'package:my_project/lab2/user_profile_page.dart';

final Map<String, WidgetBuilder> appRoutes = {
  '/': (context) => const MainPage(),
  '/login': (context) => const LoginPage(),
  '/registration': (context) => const RegistrationPage(),
  '/profile': (context) => const UserProfilePage(),
};
