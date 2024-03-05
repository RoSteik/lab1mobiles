import 'package:flutter/material.dart';

class ResponsiveConfig {
  static double iconSize(BuildContext context) =>
      MediaQuery.of(context).size.width < 600 ? 24.0 : 30.0;

  static double drawerFontSize(BuildContext context) =>
      MediaQuery.of(context).size.width < 600 ? 16.0 : 20.0;

  static double contentFontSize(BuildContext context) =>
      MediaQuery.of(context).size.width < 600 ? 20.0 : 24.0;
}
