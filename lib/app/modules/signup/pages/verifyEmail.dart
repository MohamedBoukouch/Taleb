import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:taleb/app/config/constants/app_constant.dart';
import 'package:taleb/app/modules/signup/controllers/signup_controller.dart';
import 'package:flutter_svg/flutter_svg.dart';

class VerifyEmail extends StatefulWidget {
  final String email;
  const VerifyEmail({
    Key? key,
    required this.email,
  }) : super(key: key);

  @override
  State<VerifyEmail> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  final SignupController controller = Get.put(SignupController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center, // Center content vertically
          crossAxisAlignment:
              CrossAxisAlignment.center, // Center content horizontally
          children: [
            Image.asset(
              "assets/icons/email.png",
              width: AppConstant.screenWidth * .3,
            ),
            SizedBox(
              height: AppConstant.screenHeight * .07,
            ),
            const Text(
              "Verification Code",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: AppConstant.screenHeight * .02,
            ),
            const Text(
              "Please enter the confirmation number\nthat has been sent to your mail ",
              style: TextStyle(
                color: Color.fromARGB(255, 11, 7, 7),
                fontSize: 15,
              ),
            ),
            Text(
              widget.email,
              style: const TextStyle(
                color: Colors.blue,
                fontSize: 15,
              ),
            ),
            SizedBox(
              height: AppConstant.screenHeight * .05,
            ),
            OtpTextField(
              numberOfFields: 5,
              showCursor: false,
              fieldWidth: 50,
              borderRadius: BorderRadius.circular(10),
              textStyle:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              disabledBorderColor: Colors.red,
              focusedBorderColor: Colors.orange,
              showFieldAsBox: true,
              onCodeChanged: (String code) {},
              onSubmit: (String verificationCode) async {
                try {
                  await controller.verifyemail(
                      widget.email, verificationCode, context);
                } catch ($e) {
                  print("error");
                }
                // showDialog(
                //     context: context,
                //     builder: (context) {
                //       return AlertDialog(
                //         title: Text("Verification Code"),
                //         content: Text('Code entered is $verificationCode'),
                //       );
                //     });
              }, // end onSubmit
            ),
          ],
        ),
      ),
    );
  }
}
