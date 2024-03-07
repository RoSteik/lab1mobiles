import 'package:flutter/material.dart';

import 'package:my_project/lab2/ui_logic/main/bottom_nav_bar_items.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final void Function(int) onItemTapped;

  const CustomBottomNavigationBar({
    required this.selectedIndex,
    required this.onItemTapped,
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    return BottomNavigationBar(
      items: buildBottomNavBarItems(context),
      currentIndex: selectedIndex,
      selectedItemColor: Colors.amber[800],
      onTap: onItemTapped,
    );

  }

}

