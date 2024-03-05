import 'package:flutter/material.dart';
import 'package:my_project/lab2/reusable_widgets/main/drawer_items.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: buildDrawerItems(context),
      ),
    );
  }
}
