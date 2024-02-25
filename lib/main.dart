import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: RockQuestionWidget(),
    );
  }
}

class RockQuestionWidget extends StatefulWidget {
  const RockQuestionWidget({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RockQuestionWidgetState createState() => _RockQuestionWidgetState();
}

class _RockQuestionWidgetState extends State<RockQuestionWidget> {
  String _displayText = 'Do you like rock?';
  final TextEditingController _controller = TextEditingController();

  void _updateDisplayText() {
    setState(() {
      if (_controller.text.trim().toLowerCase() == 'linkin park') {
        _displayText = 'Oh you have taste in music!';
      } else {
        _displayText = 'Give me normal rock group name';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Music Taste'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(_displayText, style: const TextStyle(fontSize: 20)),
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                key: const Key('responseField'),
                controller: _controller,
                // ignore: prefer_const_constructors
                decoration: InputDecoration(
                  labelText: 'Your answer',
                ),
                onSubmitted: (value) {
                  _updateDisplayText();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
