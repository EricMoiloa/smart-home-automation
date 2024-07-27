import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sliding_switch/sliding_switch.dart';

import '../Api services/gate_controlapi.dart';
import '../controllers/gate_controller.dart';
import '../utils/dimensions.dart';
import '../widgets/big_text.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late GateService gateService;
  late SwitchController switchController;

  @override
  void initState() {
    super.initState();
    gateService = GateService(baseUrl: 'http://127.0.0.1:8000');
    switchController = Get.put(SwitchController(gateService: gateService));
  }

  @override
  Widget build(BuildContext context) {

    
    return Scaffold(
      backgroundColor: Color.fromRGBO(244, 243, 243, 1),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(
                Iconsax.textalign_left,
                color: Colors.black87,
              ),
              onPressed: () {},
            ),
            Container(
              // margin: EdgeInsets.only(right: 100),
              width: 50.0,
              height: 50.0,
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Center(
                  child: IconButton(
                    icon: Icon(
                      Icons.logout,
                      size: 30, // Adjust the size as needed
                      color: Colors.white, // Adjust the color as needed
                    ),
                    onPressed: () {
                      // Define the action when the button is pressed
                      print("Logout button pressed");
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(Dimensions.radius30))),
              padding: EdgeInsets.all(Dimensions.width20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: Dimensions.width20),
                    child: Text("Welcome"),
                  ),
                  SizedBox(
                    height: Dimensions.height20,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            const SizedBox(height: 20),
            Container(
              margin: EdgeInsets.only(right: Dimensions.width20),
              padding: EdgeInsets.only(top: Dimensions.height20),
              height: Dimensions.screenHeight / 3,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // scrollDirection: Axis.horizontal,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(
                        right: Dimensions.width15, left: Dimensions.width20),
                    padding: EdgeInsets.only(top: Dimensions.height20),
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
                    child: Column(
                      children: [
                        Center(
                          child: Icon(
                            Icons.menu,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(
                          height: 18,
                        ),
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Text(
                              'Ai Control',
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: Dimensions.font20),
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
                            animationDuration:
                                const Duration(milliseconds: 400),
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
                    child: Column(
                      children: [
                        Center(
                          child: Icon(
                            Icons.menu,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text(
                              'Human interact',
                              style: TextStyle(
                                  color: Colors.black54, fontSize: 20),
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
                            animationDuration:
                                const Duration(milliseconds: 400),
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
                ],
              ),
            ),
            SizedBox(
              height: Dimensions.height30,
            ),
            Container(
              margin: EdgeInsets.only(
                  right: Dimensions.width15, left: Dimensions.width20),
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
                  Center(
                    child: Icon(
                      Icons.garage,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        padding: EdgeInsets.only(bottom: Dimensions.height30),
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text(
                              'Gate',
                              style: TextStyle(
                                  color: Colors.black54, fontSize: 20),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        child: Obx(
                          () => SlidingSwitch(
                            value: switchController.isOn,
                            width: 150,
                            onChanged: (bool value) =>
                                switchController.toggleSwitch(),
                            height: 39,
                            animationDuration:
                                const Duration(milliseconds: 400),
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
