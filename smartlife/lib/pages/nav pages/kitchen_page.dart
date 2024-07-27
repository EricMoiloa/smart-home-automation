import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sliding_switch/sliding_switch.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../Api services/window_control.dart';
import '../../controllers/window_controller.dart';
import '../../utils/dimensions.dart';

class kitchenScreen extends StatefulWidget {
  const kitchenScreen({Key? key}) : super(key: key);

  @override
  State<kitchenScreen> createState() => _kitchenScreenState();
}

class _kitchenScreenState extends State<kitchenScreen> {
  late WindowService windowService;
  late WindowController windowController;

  @override
  void initState() {
    super.initState();
    windowService = WindowService(baseUrl: 'http://127.0.0.1:8000');
    windowController = Get.put(WindowController(windowService: windowService));
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
                          'Open Window',
                          style: TextStyle(color: Colors.black54, fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                  Container(
                      child: Obx(
                    () => SlidingSwitch(
                      value: windowController.isOn,
                      width: 150,
                      onChanged: (bool value) =>
                          windowController.toggleSwitch(),
                      height: 39,
                      animationDuration: const Duration(milliseconds: 400),
                      onTap: () {},
                      onDoubleTap: () {},
                      onSwipe: () {},
                      textOff: "Open",
                      textOn: "Close",
                      colorOn: const Color(0xffdc6c73),
                      colorOff: const Color(0xff6682c0),
                      background: const Color(0xffe4e5eb),
                      buttonColor: const Color(0xfff7f5f7),
                      inactiveColor: const Color(0xff636f7b),
                    ),
                  )),
                ],
              ),
              SizedBox(
                height: 25,
              ),
            ],
          ),
        ),
        SizedBox(
          height: 18,
        ),
      ],
    );
  }
}
