import 'package:flutter/material.dart';
import 'package:my_project/lab2/main_page.dart';
import 'package:my_project/lab2/registration_page.dart';
import 'package:my_project/lab2/reusable_widgets/login_and_registration/custom_text_field.dart';
import 'package:my_project/lab2/reusable_widgets/login_and_registration/navigation_text_button.dart';

List<Widget> loginPageChildren = [
  const Text(
    'Fitness Tracker',
    style: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
    ),
  ),
  const SizedBox(height: 20),
  const CustomTextField(labelText: 'Email'),
  const SizedBox(height: 10),
  const CustomTextField(labelText: 'Password', obscureText: true),
  const SizedBox(height: 20),
  ElevatedButton(onPressed: () {}, child: const Text('Login')),
  const NavigationTextButton(
    text: 'Don\'t have an account? Sign up',
    destinationPage: RegistrationPage(),
  ),
  const NavigationTextButton(
    text: 'Click to home page',
    destinationPage: MainPage(),
  ),
];
