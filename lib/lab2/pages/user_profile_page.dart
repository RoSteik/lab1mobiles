import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_project/lab2/elements/responsive_config.dart';
import 'package:my_project/lab2/logic/model/user.dart';
import 'package:my_project/lab2/logic/service/auth/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';



class UserProfilePage extends StatefulWidget {
  const UserProfilePage({super.key});

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  User? _user;
  final IAuthService _authService = AuthService();

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final lastLoggedInUserEmail = prefs.getString('lastLoggedInUser');

    if (lastLoggedInUserEmail != null) {
      final userString = prefs.getString(lastLoggedInUserEmail);
      if (userString != null) {
        final Map<String, dynamic> userMap =
            jsonDecode(userString) as Map<String, dynamic>;
        setState(() {
          _user = User.fromJson(userMap);
        });
      }
    }
  }

  void _showLogoutConfirmationDialog() {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Log out'),
          content: const Text('Are you sure you want to log out?'),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Log Out'),
              onPressed: () async {
                await _authService.logout();
                Navigator.of(context).pop();
                Navigator.pushReplacementNamed(context, '/login');
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Profile'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pushReplacementNamed(context, '/home'),
        ),
        actions: [
          TextButton(
            onPressed: _showLogoutConfirmationDialog,
            child: const Text('Log Out'),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: _user != null
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: ResponsiveConfig.avatarRadius(context),
                      backgroundImage:
                          const AssetImage('assets/place_holder.jpg'),
                    ),
                    SizedBox(height: ResponsiveConfig.spacing(context)),
                    Text(
                      'Name: ${_user!.name}',
                      style: TextStyle(
                        fontSize: ResponsiveConfig.fontSizeName(context),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: ResponsiveConfig.spacing(context) / 2),
                    Text(
                      'Email: ${_user!.email}',
                      style: TextStyle(
                        fontSize: ResponsiveConfig.fontSizeEmail(context),
                      ),
                    ),
                    SizedBox(height: ResponsiveConfig.spacing(context)),
                  ],
                )
              : const Column(),
        ),
      ),
    );
  }
}
