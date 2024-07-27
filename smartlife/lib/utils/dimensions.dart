import 'package:get/get.dart';

// ignore: camel_case_types
class Dimensions {
  static double screenHeight = Get.context!.height;

  static double screenWidth = Get.context!.width;
  static double pageView = screenHeight / 2.64;
  static double pageViewContainer = screenHeight / 3.84;
  static double pageViewTextContainer = screenHeight / 7.03;

  //dynamic height padding and margin
  static double height6 = screenHeight / 90.8;
  static double height10 = screenHeight / 84.4;
  static double height15 = screenHeight / 56.27;
  static double height20 = screenHeight / 42.2;
  static double height30 = screenHeight / 28.13;
  static double height45 = screenHeight / 6.40;
  static double height50 = screenHeight / 5.12;
  static double height150 = screenHeight / 1.71;
  static double height200 = screenHeight / 2.12;
  //dynamic width padding and margin
  static double width10 = screenHeight / 84.4;
  static double width15 = screenHeight / 56.27;
  static double width20 = screenHeight / 42.2;
  static double width30 = screenHeight / 28.13;
  static double width40 = screenHeight / 21.1;
  static double width50 = screenHeight / 16.9;

  //font size
  static double font20 = screenHeight / 42.2;
  static double font16 = screenHeight / 52.75;
  static double font26 = screenHeight / 32.6;
  static double font30 = screenHeight / 28.5;

  //radius

  static double radius15 = screenHeight / 56.7;
  static double radius20 = screenHeight / 42.2;
  static double radius30 = screenHeight / 28.13;

  //icon Size
  static double iconSize24 = screenHeight / 35.17;
  static double iconSize16 = screenHeight / 52.75;

  //Listview size

  static double ListViewImgSize = screenWidth / 3.25;
  static double ListViewtextContSize = screenWidth / 3.9;

  //Popular Pharmacy
  static double popularFoodImgSize = screenHeight / 2.41;

  //Bottom height

  static double bottomHeightBar = screenHeight / 7.03;
}
