import 'package:flutter/material.dart';
import 'package:my_project/lab2/pages/main_page.dart';
import 'package:my_project/lab2/pages/registration_page.dart';

import 'package:my_project/lab2/ui_logic/login_and_registration/custom_text_field.dart';
import 'package:my_project/lab2/widgets/navigation_text_button.dart';



List<Widget> loginPageChildren(BuildContext context) {
  return [
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
    ElevatedButton(
      onPressed: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute<MainPage>(builder: (context) => const MainPage()),
        );
      },
      child: const Text(
        'Login',
        style: TextStyle(color: Colors.black),
      ),
    ),
    const NavigationTextButton(
      text: 'Don\'t have an account? Sign up',
      destinationPage: RegistrationPage(),
    ),
  ];
}
