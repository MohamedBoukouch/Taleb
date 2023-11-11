import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taleb/app/config/constants/app_constant.dart';
import 'package:taleb/app/config/themes/app_theme.dart';

class Button extends StatefulWidget {
  final String txt;
  const Button({
    Key? key,
    required this.txt,
  }) : super(key: key);

  @override
  State<Button> createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.only(top: AppConstant.screenHeight * .04),
      width: AppConstant.screenWidth * .9,
      height: AppConstant.screenHeight * .064,
      decoration: BoxDecoration(
        color: AppTheme.main_color_1,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(219, 158, 158, 158).withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Center(
        child: Text(
          widget.txt,
          style: const TextStyle(
              fontFamily: 'Inspiration',
              color: Colors.white,
              fontSize: 19,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
