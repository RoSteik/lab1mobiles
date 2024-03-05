import 'package:flutter/material.dart';
import 'package:my_project/lab2/main_page.dart';
import 'package:my_project/lab2/reusable_widgets/main/custom_bottom_navigation_bar.dart';
import 'package:my_project/lab2/reusable_widgets/main/custom_drawer.dart';
import 'package:my_project/lab2/reusable_widgets/main/navigation_logic.dart';
import 'package:my_project/lab2/reusable_widgets/main/pages_list.dart';

class MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      NavigationLogic.onItemTapped(context, index, updateIndex);
    });
  }

  void updateIndex(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Fitness Tracker')),
      drawer: const CustomDrawer(),
      body: Center(
        child: pagesList(context)[_selectedIndex],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
