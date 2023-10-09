import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:get/get.dart";
import "package:google_fonts/google_fonts.dart";

import "../constants/app_constant.dart";
import "../themes/app_theme.dart";

class AppFunction {
  AppFunction._();

  static get configureDependencies {
    SystemChrome.setPreferredOrientations(
        <DeviceOrientation>[DeviceOrientation.portraitUp]);
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        systemNavigationBarColor: AppTheme.main_color_1,
        systemNavigationBarDividerColor: AppTheme.main_color_1,
        systemNavigationBarIconBrightness: Brightness.light,
        statusBarColor: AppTheme.transparent_color,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark,
      ),
    );
  }

  static cancel() {
    return TextButton(
    child: const Text(
      "Cancel",
      style: TextStyle(
        color: Colors.red,
        fontWeight: FontWeight.bold,
      ),
    ),
    onPressed: () {
      Get.back();
    },
  );
  }
  static snackBar({required String label, Color color = AppTheme.red_color}) {
    return SnackBar(
      content: Text(
        label,
        textAlign: TextAlign.center,
        style: GoogleFonts.poppins(
          color: AppTheme.text_color_2,
          fontWeight: FontWeight.bold,
          letterSpacing: .5,
        ),
      ),
      elevation: 0,
      backgroundColor: color,
      padding: const EdgeInsets.all(10),
      width: AppConstant.screenWidth * .75,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      showCloseIcon: false,
      closeIconColor: color,
      duration: 2500.milliseconds,
      behavior: SnackBarBehavior.floating,
      dismissDirection: DismissDirection.down,
    );
  }
}