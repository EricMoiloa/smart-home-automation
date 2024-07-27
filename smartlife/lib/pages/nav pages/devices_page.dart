import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sliding_switch/sliding_switch.dart';

import '../../utils/app_colors.dart';
import '../../utils/dimensions.dart';
import '../../widgets/app_column.dart';
import '../../widgets/big_text.dart';
import '../../widgets/icons_and_text_widget.dart';
import '../../widgets/small_text.dart';

class DevicesPage extends StatefulWidget {
  DevicesPage({Key? key}) : super(key: key);

  @override
  State<DevicesPage> createState() => _DevicesPageState();
}

class _DevicesPageState extends State<DevicesPage> {
  PageController pageController = PageController(viewportFraction: 0.82);
  var _currPageValue = 0;
  double _scaleFactor = 0.8;
  double _height = Dimensions.pageViewContainer;

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currPageValue = pageController.page! as int;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

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
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Wrap(
          children: [
            //slider section
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

            //Popular Text
            SizedBox(
              height: Dimensions.height30,
            ),
            Container(
              margin: EdgeInsets.only(left: Dimensions.width30),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  BigText(text: "All Devices"),
                  SizedBox(
                    width: Dimensions.width10,
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 3.0),
                    child: BigText(
                      text: ".",
                      color: Colors.black26,
                    ),
                  ),
                  SizedBox(
                    width: Dimensions.width10,
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 2.0),
                    child: SmallText(text: "Connected"),
                  )
                ],
              ),
            ),
            //List of Pharmacies
            ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: 3,
                itemBuilder: ((context, index) {
                  return Container(
                    margin: EdgeInsets.only(
                        left: Dimensions.width20,
                        right: Dimensions.width20,
                        bottom: Dimensions.height10),
                    child: Row(
                      children: [
                        //image section in a row
                        Container(
                            height: Dimensions.ListViewImgSize,
                            width: Dimensions.ListViewImgSize,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(Dimensions.radius20),
                                color: Colors.white30,
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage("assets/images/1.jpg"))))
                        //text container
                        ,
                        Expanded(
                          child: Container(
                              height: Dimensions.ListViewtextContSize,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(
                                    Dimensions.radius20,
                                  ),
                                  bottomRight:
                                      Radius.circular(Dimensions.radius20),
                                ),
                                color: Colors.white,
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(
                                    left: Dimensions.width10,
                                    right: Dimensions.width10),
                                //mona ke mane moo u so kenya text dah
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    BigText(
                                      text: "Garden Lights",
                                      size: Dimensions.font26,
                                    ),
                                    SizedBox(
                                      height: Dimensions.height10,
                                    ),
                                    SizedBox(
                                      height: Dimensions.height10,
                                    ),
                                    Row(
                                      children: [
                                        SmallText(
                                          text: "Operation Time",
                                        ),
                                        SizedBox(
                                          width: 10.0,
                                        ),
                                        SmallText(text: "4.5"),
                                        SizedBox(
                                          width: 10.0,
                                        ),
                                        SmallText(text: "1287"),
                                        SizedBox(
                                          width: 10.0,
                                        ),
                                        SmallText(text: "Comments"),
                                      ],
                                    ),
                                    SizedBox(
                                      height: Dimensions.height20,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        BigText(text: "Status"),
                                        Container(
                                          child: SlidingSwitch(
                                            value: false,
                                            width: 150,
                                            onChanged: (bool value) {
                                              print(value);
                                            },
                                            height: 39,
                                            animationDuration: const Duration(
                                                milliseconds: 400),
                                            onTap: () {},
                                            onDoubleTap: () {},
                                            onSwipe: () {},
                                            textOff: "Close",
                                            textOn: "Open",
                                            colorOn: const Color(0xffdc6c73),
                                            colorOff: const Color(0xff6682c0),
                                            background: const Color(0xffe4e5eb),
                                            buttonColor:
                                                const Color(0xfff7f5f7),
                                            inactiveColor:
                                                const Color(0xff636f7b),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              )),
                        ),
                      ],
                    ),
                  );
                })),
          ],
        ),
      ),
    );
  }

  Widget _buildPageItem(int index) {
    Matrix4 matrix = new Matrix4.identity();
    if (index == _currPageValue.floor()) {
      var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;

      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currPageValue.floor() + 1) {
      var currScale =
          _scaleFactor + (_currPageValue - index + 1) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currPageValue.floor() - 1) {
      var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else {
      var currScale = 0.8;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, _height * (1 - _scaleFactor) / 2, 1);
    }

    return Transform(
      transform: matrix,
      child: Stack(children: [
        Container(
          height: Dimensions.pageViewContainer,
          margin: EdgeInsets.only(
            left: Dimensions.width10,
            right: Dimensions.width10,
          ),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.radius30),
              color: index.isEven ? Color(0xff69c5df) : Color(0xff9294cc),
              image: DecorationImage(
                  fit: BoxFit.cover, image: AssetImage("assets/images/1.jpg"))),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: Dimensions.pageViewTextContainer,
            margin: EdgeInsets.only(
                left: Dimensions.width30,
                right: Dimensions.width30,
                bottom: Dimensions.height30),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius20),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Color(0xffe8e8e),
                      blurRadius: 5.0,
                      offset: Offset(0, 5)),
                  BoxShadow(color: Colors.white, offset: Offset(-5, 0)),
                  BoxShadow(color: Colors.white, offset: Offset(5, 0)),
                ]),
            child: Container(
              padding: EdgeInsets.only(
                  top: Dimensions.height15, left: 15, right: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BigText(text: "Big Man Pharmacy"),
                  SizedBox(
                    height: Dimensions.height10,
                  ),
                  Row(
                    children: [
                      Wrap(
                        children: List.generate(
                          5,
                          (index) => Icon(
                            Icons.star,
                            color: AppColors.mainColor,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      SmallText(text: "4.5"),
                      SizedBox(
                        width: 10.0,
                      ),
                      SmallText(text: "1287"),
                      SizedBox(
                        width: 10.0,
                      ),
                      SmallText(text: "Comments"),
                    ],
                  ),
                  SizedBox(
                    height: Dimensions.height20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconAndtextWidget(
                          icon: Icons.circle_sharp,
                          text: "Normal",
                          iconColor: AppColors.iconColor1),
                      IconAndtextWidget(
                          icon: Icons.location_on,
                          text: "1.8km",
                          iconColor: AppColors.mainColor),
                      IconAndtextWidget(
                          icon: Icons.access_time_rounded,
                          text: "32min",
                          iconColor: AppColors.iconColor2),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
