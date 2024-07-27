import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sliding_switch/sliding_switch.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../utils/dimensions.dart';

class lightsScreen extends StatefulWidget {
  const lightsScreen({Key? key}) : super(key: key);

  @override
  State<lightsScreen> createState() => _lightsScreenState();
}

class _lightsScreenState extends State<lightsScreen> {
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(height: 20),
        Container(
          margin: const EdgeInsets.only(right: 8.0),
          padding: const EdgeInsets.only(top: 10),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                offset: const Offset(1, 2),
                blurRadius: 1,
              ),
            ],
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          width: double.maxFinite,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text(
                          'Outdoor Lights',
                          style: TextStyle(color: Colors.black54, fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    child: SlidingSwitch(
                      width: 150,
                      value: _isLedOn,
                      onChanged: (bool value) {
                        controlLED(value);
                      },
                      height: 39,
                      animationDuration: const Duration(milliseconds: 400),
                      onTap: () {},
                      onDoubleTap: () {},
                      onSwipe: () {},
                      textOff: "Off",
                      textOn: "On",
                      colorOn: const Color(0xffdc6c73),
                      colorOff: const Color(0xff6682c0),
                      background: const Color(0xffe4e5eb),
                      buttonColor: const Color(0xfff7f5f7),
                      inactiveColor: const Color(0xff636f7b),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 25,
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          height: 18,
        ),
      ],
    );
  }
}
