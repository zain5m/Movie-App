import 'package:flutter/material.dart';
import 'package:move/core/utils/global/color_constance.dart';

Widget itemNavigationBar({
  required IconData icon,
  required bool tap,
  required Function() onTap,
}) {
  return InkResponse(
    onTap: onTap,
    child: Container(
      height: 35,
      width: 54,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: ColorConstance.colorItemNavBar,
        boxShadow: tap
            ? [
                BoxShadow(
                  color: Colors.white.withOpacity(0.1),
                  blurRadius: 15,
                  offset: Offset(-8, -5),
                ),
                BoxShadow(
                  color: Colors.black,
                  blurRadius: 3,
                  offset: Offset(5, 6),
                ),
              ]
            : [
                BoxShadow(
                  color: Colors.black,
                  blurRadius: 3,
                  offset: Offset(-3, -3),
                ),
                BoxShadow(
                  color: Colors.white.withOpacity(0.1),
                  blurRadius: 8,
                  offset: Offset(3, 3),
                ),
              ],
      ),
      child: Icon(
        icon,
        size: 25,
        shadows: tap
            ? [
                Shadow(
                  color: Colors.white.withOpacity(0.1),
                  blurRadius: 20,
                  offset: Offset(15, 5),
                ),
                Shadow(
                  color: Color(0XFF181823),
                  blurRadius: 50,
                  offset: Offset(-10, -4),
                ),
              ]
            : null,
      ),
    ),
  );
}
