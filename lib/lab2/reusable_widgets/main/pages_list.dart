import 'package:flutter/material.dart';

import 'package:my_project/lab2/reusable_widgets/main/responsive_config.dart';

List<Widget> pagesList(BuildContext context) {
  final contentFontSize = ResponsiveConfig.contentFontSize(context);
  return [
    Center(
      child: Text('Home', style: TextStyle(fontSize: contentFontSize)),
    ),
    Center(
      child: Text('Activity', style: TextStyle(fontSize: contentFontSize)),
    ),
  ];
}
