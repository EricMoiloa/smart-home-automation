import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sliding_switch/sliding_switch.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../Api services/fan_control.dart';
import '../../Api services/living_room_lightsapi.dart';
import '../../controllers/fan_controller.dart';
import '../../controllers/livingroom_lights_controller.dart';
import '../../utils/dimensions.dart';
import 'brightnessControl.dart';
import 'progress_bar.dart';

class LivingroomScreen extends StatefulWidget {
  const LivingroomScreen({Key? key}) : super(key: key);

  @override
  State<LivingroomScreen> createState() => _LivingroomScreenState();
}

class _LivingroomScreenState extends State<LivingroomScreen> {
  late FanService fanService;
  late FanController fanController;
  late LivingRoomLightsService livingRoomLightsService;
  late LivingRoomLightsController livingRoomLightsController;

  @override
  void initState() {
    super.initState();
    fanService = FanService(baseUrl: 'http://127.0.0.1:8000');
    fanController = Get.put(FanController(fanService: fanService));
    livingRoomLightsService =
        LivingRoomLightsService(baseUrl: 'http://127.0.0.1:8000');
    livingRoomLightsController = Get.put(
        LivingRoomLightsController(livingRoomService: livingRoomLightsService));
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
                          'Living Room Lights',
                          style: TextStyle(color: Colors.black54, fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    child: Obx(
                      () => SlidingSwitch(
                        value: livingRoomLightsController.isOn,
                        width: 150,
                        onChanged: (bool value) =>
                            livingRoomLightsController.toggleSwitch(),
                        height: 39,
                        animationDuration: const Duration(milliseconds: 400),
                        onTap: () {},
                        onDoubleTap: () {},
                        onSwipe: () {},
                        textOff: "OFf",
                        textOn: "On",
                        colorOn: const Color(0xffdc6c73),
                        colorOff: const Color(0xff6682c0),
                        background: const Color(0xffe4e5eb),
                        buttonColor: const Color(0xfff7f5f7),
                        inactiveColor: const Color(0xff636f7b),
                      ),
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
        Container(
          height: 196,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(
                    right: Dimensions.width15, left: Dimensions.width15),
                padding: EdgeInsets.only(top: 20),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.01),
                        offset: Offset(1, 2),
                        blurRadius: 1)
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                ),
                width: Dimensions.screenWidth / 2.2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      height: 18,
                    ),
                    Align(
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          'Turn on Heating System',
                          style: TextStyle(color: Colors.black54, fontSize: 20),
                        ),
                      ),
                    ),
                    Container(
                      child: SlidingSwitch(
                        value: false,
                        width: 150,
                        onChanged: (bool value) {
                          print(value);
                        },
                        height: 39,
                        animationDuration: const Duration(milliseconds: 400),
                        onTap: () {},
                        onDoubleTap: () {},
                        onSwipe: () {},
                        textOff: "Close",
                        textOn: "Open",
                        colorOn: const Color(0xffdc6c73),
                        colorOff: const Color(0xff6682c0),
                        background: const Color(0xffe4e5eb),
                        buttonColor: const Color(0xfff7f5f7),
                        inactiveColor: const Color(0xff636f7b),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                    right: Dimensions.width15, left: Dimensions.width20),
                padding: EdgeInsets.only(top: 20),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.01),
                        offset: Offset(1, 2),
                        blurRadius: 1)
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                ),
                width: Dimensions.screenWidth / 2.1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Align(
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          'Turn On fan',
                          style: TextStyle(color: Colors.black54, fontSize: 20),
                        ),
                      ),
                    ),
                    Container(
                      child: Obx(
                        () => SlidingSwitch(
                          value: fanController.isOn,
                          width: 150,
                          onChanged: (bool value) =>
                              fanController.toggleSwitch(),
                          height: 39,
                          animationDuration: const Duration(milliseconds: 400),
                          onTap: () {},
                          onDoubleTap: () {},
                          onSwipe: () {},
                          textOff: "Close",
                          textOn: "Open",
                          colorOn: const Color(0xffdc6c73),
                          colorOff: const Color(0xff6682c0),
                          background: const Color(0xffe4e5eb),
                          buttonColor: const Color(0xfff7f5f7),
                          inactiveColor: const Color(0xff636f7b),
                        ),
                      ),
                    ),
                  ],
                ),
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
