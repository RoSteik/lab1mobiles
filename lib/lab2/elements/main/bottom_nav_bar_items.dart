import 'package:flutter/material.dart';

import 'package:my_project/lab2/elements/responsive_config.dart';

List<BottomNavigationBarItem> buildBottomNavBarItems(BuildContext context) {
  final iconSize = ResponsiveConfig.iconSize(context);
  return [
    BottomNavigationBarItem(
      icon: Icon(Icons.home, size: iconSize),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.fitness_center, size: iconSize),
      label: 'Activity',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person, size: iconSize),
      label: 'Profile',
    ),
  ];
}
