import 'package:flash_light_control_plugin/flash_light_control_plugin.dart';
import 'package:flutter/material.dart';
import 'package:my_project/lab2/elements/responsive_config.dart';

List<Widget> pagesList(BuildContext context) {
  final contentFontSize = ResponsiveConfig.contentFontSize(context);
  return [
    Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ElevatedButton(
            onPressed: FlashLightControlPlugin.turnOn,
            child: Text('Turn ON Flashlight',
                style: TextStyle(fontSize: contentFontSize),),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: FlashLightControlPlugin.turnOff,
            child: Text('Turn OFF Flashlight',
                style: TextStyle(fontSize: contentFontSize),),
          ),
        ],
      ),
    ),
    Center(
      child: Text('Activity', style: TextStyle(fontSize: contentFontSize)),
    ),
  ];
}
