import 'package:flutter/material.dart';

import 'package:my_project/lab2/elements/login_and_registration/login_page_children.dart';


class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: loginPageChildren(context),
        ),
      ),
    );
  }
}
