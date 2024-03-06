import 'package:flutter/material.dart';


import 'package:my_project/lab2/reusable_widgets/login_and_registration/custom_button.dart';
import 'package:my_project/lab2/reusable_widgets/login_and_registration/custom_text_button.dart';
import 'package:my_project/lab2/reusable_widgets/login_and_registration/custom_text_field.dart';

List<Widget> registrationPageChildren(BuildContext context) {
  return [
    const CustomTextField(labelText: 'Name'),
    const SizedBox(height: 10),
    const CustomTextField(labelText: 'Email'),
    const SizedBox(height: 10),
    const CustomTextField(labelText: 'Password', obscureText: true),
    const SizedBox(height: 20),
    CustomButton(
      text: 'Sign Up',
      onPressed: () {  },
    ),
    CustomTextButton(
      text: 'Already have an account? Login',
      onPressed: () => Navigator.pushNamed(context, '/login'),
    ),
  ];
}
