import 'package:flash_light_control_plugin/flash_light_control_plugin.dart';
import 'package:flutter/foundation.dart' show kIsWeb, TargetPlatform;
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
            onPressed: () => _handleFlashlightButton(context, turnOn: true),
            child: Text(
              'Turn ON Flashlight',
              style: TextStyle(fontSize: contentFontSize),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => _handleFlashlightButton(context, turnOn: false),
            child: Text(
              'Turn OFF Flashlight',
              style: TextStyle(fontSize: contentFontSize),
            ),
          ),
        ],
      ),
    ),
    Center(
      child: Text('Activity', style: TextStyle(fontSize: contentFontSize)),
    ),
  ];
}

void _handleFlashlightButton(BuildContext context, {required bool turnOn}) {
  if (kIsWeb || Theme.of(context).platform == TargetPlatform.iOS) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Feature Not Supported'),
          content: const Text(
            'Flashlight functionality is not supported on this platform.',
          ),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  } else {
    if (turnOn) {
      FlashLightControlPlugin.turnOn();
    } else {
      FlashLightControlPlugin.turnOff();
    }
  }
}
