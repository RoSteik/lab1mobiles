import 'package:flutter/material.dart';
import 'package:my_project/lab2/reusable_widgets/main/pages_list.dart';

class NavigationLogic {
  static void onItemTapped(
    BuildContext context,
    int index,
    void Function(int) updateIndex,
  ) {
    if (index < pagesList(context).length) {
      updateIndex(index);
    } else if (index == 2) {
      Navigator.pushNamed(context, '/profile').then((value) {
        updateIndex(0);
      });
    }
  }
}
