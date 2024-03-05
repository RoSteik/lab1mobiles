import 'package:flutter/material.dart';
import 'package:my_project/lab2/reusable_widgets/user/user_profile_appbar.dart';
import 'package:my_project/lab2/reusable_widgets/user/user_profile_body.dart';

class UserProfilePage extends StatelessWidget {
  const UserProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: userProfileAppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: userProfileBody(context),
          ),
        ),
      ),
    );
  }
}
