import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ButtonBack extends StatelessWidget {
  const ButtonBack({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.back();
      },
      child: CircleAvatar(
        radius: 25,
        backgroundColor: Colors.white,
        child: Image.asset("assets/icons/back.png"),
      ),
    );
  }
}
