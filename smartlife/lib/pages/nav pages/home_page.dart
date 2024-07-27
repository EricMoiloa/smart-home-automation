import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sliding_switch/sliding_switch.dart';

import '../../utils/dimensions.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(244, 243, 243, 1),
      appBar: AppBar(
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
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/1.jpg"),
                      fit: BoxFit.cover),
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.grey.withOpacity(0.5)),
            ),
          ],
        ),
      ),
      body: Column(
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

                //create a weather container below here....

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Container(
                    child: Column(
                      children: [],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Operation Modes',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  height: 200,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(right: 15.0),
                        padding: EdgeInsets.only(top: 20),
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.01),
                                offset: Offset(1, 2),
                                blurRadius: 1)
                          ],
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        width: 200,
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
                            Container(
                              padding: EdgeInsets.only(top: 20, left: 2),
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
                                textOff: "Female",
                                textOn: "Male",
                                colorOn: const Color(0xffdc6c73),
                                colorOff: const Color(0xff6682c0),
                                background: const Color(0xffe4e5eb),
                                buttonColor: const Color(0xfff7f5f7),
                                inactiveColor: const Color(0xff636f7b),
                              ),
                            ),
                            SizedBox(
                              height: 18,
                            ),
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Text(
                                  'Best Design',
                                  style: TextStyle(
                                      color: Colors.black54, fontSize: 20),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 15.0),
                        padding: EdgeInsets.only(top: 20),
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.01),
                                offset: Offset(1, 2),
                                blurRadius: 1)
                          ],
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        width: 200,
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
                            Container(
                              padding: EdgeInsets.only(top: 20, left: 2),
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
                                textOff: "Female",
                                textOn: "Male",
                                colorOn: const Color(0xffdc6c73),
                                colorOff: const Color(0xff6682c0),
                                background: const Color(0xffe4e5eb),
                                buttonColor: const Color(0xfff7f5f7),
                                inactiveColor: const Color(0xff636f7b),
                              ),
                            ),
                            SizedBox(
                              height: 18,
                            ),
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Text(
                                  'Best Design',
                                  style: TextStyle(
                                      color: Colors.black54, fontSize: 20),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 15.0),
                        padding: EdgeInsets.only(top: 20),
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.01),
                                offset: Offset(1, 2),
                                blurRadius: 1)
                          ],
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        width: 200,
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
                            Container(
                              padding: EdgeInsets.only(top: 20, left: 2),
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
                                textOff: "Female",
                                textOn: "Male",
                                colorOn: const Color(0xffdc6c73),
                                colorOff: const Color(0xff6682c0),
                                background: const Color(0xffe4e5eb),
                                buttonColor: const Color(0xfff7f5f7),
                                inactiveColor: const Color(0xff636f7b),
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
                                  'Best Design',
                                  style: TextStyle(
                                      color: Colors.black54, fontSize: 20),
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
                Container(
                  margin: EdgeInsets.only(right: 15.0),
                  padding: EdgeInsets.only(top: 20),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          offset: Offset(1, 2),
                          blurRadius: 1)
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  width: double.maxFinite,
                  child: Column(
                    children: [
                      Center(
                        child: Icon(
                          Iconsax.gas_station,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(
                        height: 18,
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 20, left: 2),
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
                          textOff: "Female",
                          textOn: "Male",
                          colorOn: const Color(0xffdc6c73),
                          colorOff: const Color(0xff6682c0),
                          background: const Color(0xffe4e5eb),
                          buttonColor: const Color(0xfff7f5f7),
                          inactiveColor: const Color(0xff636f7b),
                        ),
                      ),
                      SizedBox(
                        height: 18,
                      ),
                      Container(
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text(
                              'Best Design',
                              style: TextStyle(
                                  color: Colors.black54, fontSize: 20),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
