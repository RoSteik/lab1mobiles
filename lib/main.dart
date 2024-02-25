import 'package:flutter/material.dart';


void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: IncrementApp(),
    );
  }
}

class IncrementApp extends StatefulWidget {
  const IncrementApp({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _IncrementAppState createState() => _IncrementAppState();
}

class _IncrementAppState extends State<IncrementApp> {
  int _incrementValue = 0;
  final TextEditingController _controller = TextEditingController();

  void _updateIncrement(String value) {
    if (value == 'Avada Kedavra') {
      setState(() {
        _incrementValue = 0;
      });
    } else {
      final int? number = int.tryParse(value);
      if (number != null) {
        setState(() {
          _incrementValue += number;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Increment App'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Increment Value: $_incrementValue', style: const TextStyle(fontSize: 24)),
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              key: const Key('inputField'), // Use key in widget constructors
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Enter number or "Avada Kedavra" to reset',
              ),
              onSubmitted: _updateIncrement,
            ),
          ),
        ],
      ),
    );
  }
}
