import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_project/lab2/elements/responsive_config.dart';
import 'package:my_project/lab2/logic/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({super.key});

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  User? _user;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final key = prefs.getKeys().first.toString();
    final userString = prefs.getString(key);
    if (userString != null) {
      final Map<String, dynamic> userMap =
          jsonDecode(userString) as Map<String, dynamic>;
      setState(() {
        _user = User.fromJson(userMap);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {},
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
                          fontSize: ResponsiveConfig.fontSizeEmail(context),),
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

// class UserProfilePage extends StatelessWidget {
//   const UserProfilePage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('User Profile'),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.edit),
//             onPressed: () {},
//           ),
//         ],
//       ),
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(20),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               CircleAvatar(
//                 radius: ResponsiveConfig.avatarRadius(context),
//                 backgroundImage: const AssetImage('assets/place_holder.jpg'),
//               ),
//               SizedBox(height: ResponsiveConfig.spacing(context)),
//               Text(
//                 'Name: John Doe',
//                 style: TextStyle(
//                   fontSize: ResponsiveConfig.fontSizeName(context),
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               SizedBox(height: ResponsiveConfig.spacing(context) / 2),
//               Text(
//                 'Email: johndoe@example.com',
//                 style: TextStyle(
//                     fontSize: ResponsiveConfig.fontSizeEmail(context)),
//               ),
//               SizedBox(height: ResponsiveConfig.spacing(context)),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
