import 'package:flutter/material.dart';

class UserProfilePage extends StatelessWidget {
  const UserProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final bool isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;

    final double avatarRadius = screenSize.width < 600 ? 39.0 : 45.0;
    final double spacing = screenSize.height / (isLandscape ? 40 : 20);
    final double fontSizeName = screenSize.width < 600 ? 16.0 : 20.0;
    final double fontSizeEmail = screenSize.width < 600 ? 20.0 : 24.0;

    return Scaffold(
      appBar: AppBar(
        title: const Text('User Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {  },
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: avatarRadius,
                backgroundImage: const NetworkImage('https://via.placeholder.com/150'),
              ),
              SizedBox(height: spacing),
              Text(
                'Name: John Doe',
                style: TextStyle(fontSize: fontSizeName,
                  fontWeight: FontWeight.bold,),
              ),
              SizedBox(height: spacing / 2),
              Text(
                'Email: johndoe@example.com',
                style: TextStyle(fontSize: fontSizeEmail),
              ),
              SizedBox(height: spacing),
            ],
          ),
        ),
      ),
    );
  }
}
