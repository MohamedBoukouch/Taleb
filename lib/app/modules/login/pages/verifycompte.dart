import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:taleb/app/config/constants/app_constant.dart';
import 'package:taleb/app/modules/login/controllers/login_controller.dart';
import 'package:taleb/app/modules/login/pages/ResetPassword.dart';
import 'package:taleb/app/shared/bottun.dart';

import '../../../shared/back.dart';

class VerifyCompte extends StatefulWidget {
  final String email;
  const VerifyCompte({
    Key? key,
    required this.email,
  }) : super(key: key);

  @override
  State<VerifyCompte> createState() => _VerifyCompteState();
}

class _VerifyCompteState extends State<VerifyCompte> {
  late String verificationCode;
  LoginController controller = Get.put(LoginController());
  late String otpcontroller;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const ButtonBack(),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20.0,top: 50), // Add left padding
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Align content to the left
          children: [
            Text(
              "Verify Your Email",
              style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Bitter', fontSize: 20),
            ),
            Text(
              "Plais Enter The 5 Digit Code  Sent To ",
              style: TextStyle(fontFamily: 'Bitter'),
            ),
            Text(
              widget.email,
              style: TextStyle(color: Colors.blue, fontFamily: 'Bitter'),
            ),
            SizedBox(
              height: AppConstant.screenHeight * .05,
            ),
            OtpTextField(
              numberOfFields: 5,
              showCursor: false,
              fieldWidth: 50,
              borderRadius: BorderRadius.circular(10),
              textStyle: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),
              disabledBorderColor: Colors.red,
              focusedBorderColor: Colors.orange,
              showFieldAsBox: true,
              onCodeChanged: (String code) {
                // verificationCode = code;
              },
              onSubmit: (String verificationCode) async {
                otpcontroller = verificationCode;
              },
            ),
            SizedBox(
              height: AppConstant.screenHeight * .04,
            ),
            InkWell(
              onTap: () async {
                print(otpcontroller);
                try {
                  await controller.verifycompte(widget.email, otpcontroller, context);
                } catch ($e) {
                  print("error");
                }
              },
              child: Button(txt: "Verify"),
            ),
          ],
        ),
      ),
    );
  }
}
