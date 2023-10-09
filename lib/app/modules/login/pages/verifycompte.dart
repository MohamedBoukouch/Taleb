import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:taleb/app/config/constants/app_constant.dart';
import 'package:taleb/app/modules/login/controllers/login_controller.dart';
import 'package:taleb/app/modules/login/pages/ResetPassword.dart';
import 'package:taleb/app/shared/bottun.dart';

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
  // final TextEditingController _otpcontroller = TextEditingController();
  late String otpcontroller;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Verify Your Email"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset("assets/icons/close_lock.png"),
          SizedBox(
            height: AppConstant.screenHeight * .05,
          ),
          const Text("Plais Enter The 5 Digit Code  Sent To "),
          const Text(
            "boukouchmohames@gmail.com",
            style: TextStyle(
              color: Colors.blue,
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
            textStyle: TextStyle(
              fontWeight: FontWeight.bold,
            ),
            disabledBorderColor: Colors.red,
            focusedBorderColor: Colors.orange,
            showFieldAsBox: true,

            onCodeChanged: (String code) {
              // verificationCode = code;
            },

            onSubmit: (String verificationCode) async {
              otpcontroller = verificationCode;
              //   Text("hello");
              // try {
              //   await controller.verifyemail(
              //       widget.email, verificationCode, context);
              // } catch ($e) {
              //   print("error");
              // }
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
          SizedBox(
            height: AppConstant.screenHeight * .04,
          ),
          InkWell(
              onTap: () async {
                print(otpcontroller);
                try {
                  await controller.verifycompte(
                      widget.email, otpcontroller, context);
                } catch ($e) {
                  print("error");
                }
              },
              child: Button(txt: "Verify")),
        ],
      ),
    );
  }
}
