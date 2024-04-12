import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taleb/app/config/constants/app_constant.dart';
import 'package:taleb/app/modules/login/controllers/login_controller.dart';
import 'package:taleb/app/modules/login/pages/verifycompte.dart';
import 'package:taleb/app/shared/bottun.dart';
import 'package:taleb/app/shared/edittext.dart';

import '../../../shared/back.dart';

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
        leading: ButtonBack(),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16.0,right: 16), // Add left padding
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Align content to the left
          children: [
            const SizedBox(height: 50,),
            Text(
              "Forgot_Password".tr,
              style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Bitter',fontSize: 20),
            ),
            Text(
              "Forgot_Password_info".tr,
              style: TextStyle(fontFamily: 'Bitter'),
            ),
            const SizedBox(height: 50,),
            Form(
              key: _checkemailKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start, // Align content to the left
                children: [
                  Text(
                    "Address".tr,
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 5,),
                  Edittext(
                      readonly: false,
                      hint: "Address".tr,
                      isemail: true,
                      ispassword: false,
                      icon: const Icon(Icons.email_outlined),
                      Controller: _emailController,
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return "Vide";
                        } else if (!value.contains("@") || !value.contains(".")) {
                          return "Invalid Email";
                        }
                        return null;
                      },
                    ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
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
                txt: "Envoyer".tr,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
