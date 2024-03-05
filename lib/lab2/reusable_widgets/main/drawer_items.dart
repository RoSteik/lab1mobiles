import 'package:flutter/material.dart';
import 'package:my_project/lab2/reusable_widgets/main/responsive_config.dart';


List<Widget> buildDrawerItems(BuildContext context) {
  final drawerFontSize = ResponsiveConfig.drawerFontSize(context);
  return [
    const DrawerHeader(
      decoration: BoxDecoration(color: Colors.blue),
      child: Text('Menu'),
    ),
    ListTile(
      title: Text('Home', style: TextStyle(fontSize: drawerFontSize)),
      onTap: () => Navigator.pop(context),
    ),
    ListTile(
      title: Text('Settings', style: TextStyle(fontSize: drawerFontSize)),
      onTap: () => Navigator.pop(context),
    ),
  ];
}
