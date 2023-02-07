import 'package:flutter/material.dart';

void navigatorTo(context, nextScreen) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => nextScreen,
      ),
    );
Widget nullImage({
  double? height,
  double? width,
}) =>
    Image.asset(
      "assets/images/not_found.png",
      height: height,
      width: width,
      fit: BoxFit.cover,
    );
