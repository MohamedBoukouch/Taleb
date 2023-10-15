import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:taleb/app/config/constants/app_constant.dart';

class SplashButton extends StatelessWidget {
  const SplashButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      width: AppConstant.screenWidth * .8,
      height: 50,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16), color: Colors.orange),
      child: MaterialButton(
        onPressed: () {},
        child: const Text(
          "Continue",
          style: TextStyle(
              color: Colors.white, fontFamily: 'Bitter', fontSize: 16),
        ),
        // color: Colors.orange,
      ),
    );
  }
}
