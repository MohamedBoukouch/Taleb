import 'package:flutter/cupertino.dart';
import 'package:taleb/app/config/constants/app_constant.dart';

class Type_language extends StatelessWidget {
  String text;
  Type_language({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppConstant.screenWidth,
      height: AppConstant.screenHeight * .07,
      decoration: BoxDecoration(
          border: Border.all(
            color: Color(0xFFD9D9D9),
            width: 1, // Adjust the width as needed
          ),
          color: Color(0xFFF5F5F5),
          borderRadius: BorderRadius.circular(7)),
      child: Center(
        child: Text(
          text,
          style: TextStyle(color: Color.fromARGB(255, 70, 69, 69)),
        ),
      ),
    );
  }
}
