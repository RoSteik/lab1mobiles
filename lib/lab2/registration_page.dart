import 'package:flutter/material.dart';
import 'package:my_project/lab2/reusable_widgets/login_and_registration/registration_page_children.dart';

class RegistrationPage extends StatelessWidget {
  const RegistrationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: registrationPageChildren(context),
        ),
      ),
    );
  }
}
