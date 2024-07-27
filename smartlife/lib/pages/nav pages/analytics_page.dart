import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AnalyticPage extends StatefulWidget {
  const AnalyticPage({super.key});

  @override
  State<AnalyticPage> createState() => _AnalyticPageState();
}

class _AnalyticPageState extends State<AnalyticPage> {
   bool _isLedOn = false;

  Future<void> controlLED(bool state) async {
    final response = await http.post(
      Uri.parse('http://127.0.0.1:8000/led/'), // Replace with your FastAPI URL
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, bool>{'state': state}),
    );

    if (response.statusCode == 200) {
      setState(() {
        _isLedOn = state;
      });
    } else {
      throw Exception('Failed to update LED state');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Control LED'),
      ),
      body: Center(
        child: SwitchListTile(
          title: Text("LED"),
          value: _isLedOn,
          onChanged: (bool value) {
            controlLED(value);
          },
        ),
      ),
    );
  }
}
