// ignore_for_file: constant_identifier_names

import "package:flutter/material.dart";

class AppTheme {
  AppTheme._();

  static const Color transparent_color = Color(0x00000000);
  static const Color shadow_color = Color(0xFF252525);
  static const Color border_color = Color(0xFF252525);
  static const Color green_color = Color(0xff08ff00);
  static const Color red_color = Color(0xfffd0000);

  /// TODO : Main colors
  static const Color main_color_1 = Color(0xFFF008080 );
  static const Color main_color_2 = Color(0xFFF20b2aa );
  static const Color main_color_3 = Color(0xFFF367588 );

  /// TODO : Backs
  static const Color blue_color_1 = Color.fromARGB(57, 37, 37, 37);
  static const Color back_color_2 = Color(0xFFFFFFFF);
  static const Color back_color_3 = Color(0xFFA0A0A0);
  static const Color back_color_4 = Color(0xFFF0F0F0);

  /// TODO : Texts
  static const Color text_color_1 = Color(0xFF252525);
  static const Color text_color_2 = Color(0xFFFFFFFF);
  static const Color text_color_3 = Color(0xFFA9A9A9);

  /// TODO : Icons
  static const Color icon_color_1 = Color(0xFF252525);
  static const Color icon_color_2 = Color(0xFFFFFFFF);
  static const Color icon_color_3 = Color(0xFFA9A9A9);

  /// Do Not Use This colors

  static const Color yellow_color = Color(0xffffebd2a);
  static const Color box_color = Color.fromARGB(58, 255, 255, 255);
  static const Color reed_color = Color(0xffff15f35);
  static const Color whit_color = Color(0xfffffffff);
  static const Color inscrire_color = Colors.red;
  static const Color barr_color = Colors.white;
  static const Color enligne_color = Color(0xfff27bb7b);
  static const Color statu_bg = Color(0xfffd9d9d9);
  static const Color select_bg = Color.fromARGB(72, 254, 190, 42);
  static const Color orange_color = Color(0xffffebd2a);
  static const Color transparent = Color.fromARGB(0, 254, 190, 42);
  static const Color grey = Color(0xfffd1d1d1);
  static const Color black_color = Colors.black;
  static const Color grey_search = Color(0xfff565656);
  static const Color grey_circle = Color(0xfffa4a4a4);
  static const Color grey_favorit = Color(0xfffd1d1d1);

  static ThemeData get light {
    return ThemeData(
      scaffoldBackgroundColor: back_color_2,
      primaryColor: transparent_color,
      splashColor: transparent_color,
      appBarTheme: const AppBarTheme(
        elevation: 0,
        centerTitle: true,
        backgroundColor: back_color_2,
        titleTextStyle: TextStyle(
          color: AppTheme.text_color_1,
          fontWeight: FontWeight.bold,
          letterSpacing: .5,
          fontSize: 20,
        ),
      ),
    );
  }
}
