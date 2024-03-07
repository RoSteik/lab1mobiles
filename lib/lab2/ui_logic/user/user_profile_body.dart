import 'package:flutter/material.dart';

import 'package:my_project/lab2/ui_logic/responsive_config.dart';



List<Widget> userProfileBody(BuildContext context) {
  return [
    CircleAvatar(
      radius: ResponsiveConfig.avatarRadius(context),
      backgroundImage: const AssetImage('assets/place_holder.jpg'),
    ),
    SizedBox(height: ResponsiveConfig.spacing(context)),
    Text(
      'Name: John Doe',
      style: TextStyle(
        fontSize: ResponsiveConfig.fontSizeName(context),
        fontWeight: FontWeight.bold,
      ),
    ),
    SizedBox(height: ResponsiveConfig.spacing(context) / 2),
    Text(
      'Email: johndoe@example.com',
      style: TextStyle(fontSize: ResponsiveConfig.fontSizeEmail(context)),
    ),
    SizedBox(height: ResponsiveConfig.spacing(context)),
  ];
}
