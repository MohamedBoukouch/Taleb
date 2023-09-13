// ignore_for_file: non_constant_identifier_names, constant_identifier_names

import "package:flutter/material.dart";
import "package:get/get.dart";

// import "../themes/app_theme.dart";

class AppConstant {
  AppConstant._();

  /// TODO : Screen Size
  static double screenWidth = Get.width;
  static double screenHeight = Get.height;

  static const Curve curve = Curves.linearToEaseOut;
  static const Transition transition = Transition.topLevel;
  static const Duration duration = Duration(milliseconds: 1500);

  /// TODO : BoxShadow
  static const BorderRadius borderRadius = BorderRadius.all(Radius.circular(radius));
  // static Border border = Border.all(color: AppTheme.main_color_1, width: 1);
  static const double radius = 20;
  static const double padding = 10;
  static const double iconSize = 25;
  static const double heightBar = 65;

  /// TODO : OutlineInputBorder
  static const OutlineInputBorder inputBorder = OutlineInputBorder(
    borderSide: BorderSide(
      // color: AppTheme.main_color_1,
      width: 1,
    ),
    borderRadius: borderRadius,
  );
}
