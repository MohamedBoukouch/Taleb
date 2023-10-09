import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taleb/app/config/constants/app_constant.dart';
import 'package:taleb/app/modules/login/controllers/login_controller.dart';
import 'package:taleb/app/modules/login/pages/verifycompte.dart';
import 'package:taleb/app/shared/bottun.dart';
import 'package:taleb/app/shared/edittext.dart';

class CheckEmail extends StatefulWidget {
  const CheckEmail({Key? key}) : super(key: key);

  @override
  State<CheckEmail> createState() => _CheckEmailState();
}

class _CheckEmailState extends State<CheckEmail> {
  final LoginController controller = Get.put(LoginController());
  final GlobalKey<FormState> _checkemailKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Forgot Password"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset("assets/icons/close_lock.png"),
            SizedBox(
              height: AppConstant.screenHeight * .05,
            ),
            Text(
                "Plais Enter your Email Address To \n Recieve a verification code."),
            SizedBox(
              height: AppConstant.screenHeight * .05,
            ),
            Form(
              key: _checkemailKey,
              child: Column(
                children: [
                  Container(
                    margin:
                        EdgeInsets.only(right: AppConstant.screenWidth * .60),
                    child: Text(
                      "Address Email",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        left: AppConstant.screenHeight * .035,
                        right: AppConstant.screenHeight * .035,
                        top: AppConstant.screenHeight * .01),
                    child: Edittext(
                      hint: "Adress Email",
                      isemail: true,
                      ispassword: false,
                      icon: const Icon(Icons.email_outlined),
                      Controller: _emailController,
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return "Vide";
                        } else if (!value.contains("@") ||
                            !value.contains(".")) {
                          return "Invalid Email";
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () async {
                if (_checkemailKey.currentState!.validate()) {
                  FocusScope.of(context).unfocus();
                  try {
                    await controller.checkemail(_emailController.text, context);
                  } catch (e) {}
                }
              },
              child: Button(
                txt: "Send",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
