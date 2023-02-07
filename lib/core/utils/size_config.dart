import 'package:flutter/material.dart';

// abstract class MediaQueryClass {
//   void call(BuildContext context);
// }

class SizeConfig {
// extends MediaQueryClass {
  static late MediaQueryData mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static late double screentext;

  // static double? defaultSize;
  // static Orientation? orientation;
  // static double? sorientation;

  void init(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    screenWidth = mediaQueryData.size.width;
    screenHeight = mediaQueryData.size.height;
    screentext = mediaQueryData.textScaleFactor;
    // orientation = mediaQueryData.orientation;
  }

  // @override
  // void call(BuildContext context) {
  //   mediaQueryData = MediaQuery.of(context);
  //   screenWidth = mediaQueryData.size.width;
  //   screenHeight = mediaQueryData.size.height;
  //   screentext = mediaQueryData.textScaleFactor;
  // }
}

//! Get the proportionate height as per screen size
double getProportionateScreenHeight(double inputHeight) {
  double screenHeight = SizeConfig.screenHeight;
  //* 812 is the layout height that designer use
  return (inputHeight / 812.0) * screenHeight;
}

//! Get the proportionate height as per screen size
double getProportionateScreenWidth(double inputWidth) {
  double screenWidth = SizeConfig.screenWidth;
  //* 375 is the layout width that designer use

  return (inputWidth / 375.0) * screenWidth;
}
