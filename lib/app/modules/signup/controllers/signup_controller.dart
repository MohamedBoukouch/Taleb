import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taleb/app/config/constants/app_constant.dart';
import 'package:taleb/app/config/function/functions.dart';
import 'package:taleb/app/data/Crud.dart';
import 'package:taleb/app/data/const_link.dart';
import 'package:taleb/app/modules/home/views/home_view.dart';
import 'package:taleb/app/modules/login/views/login_view.dart';
import 'package:taleb/app/modules/signup/pages/verifyEmail.dart';
import 'package:taleb/main.dart';

class SignupController extends GetxController {
  //TODO: Implement SignupController

  Crud _crud = Crud();

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;

  signup(
      String firstname, String lastname, String email, String password) async {
    var response = await _crud.postRequest(linksignup, {
      "firstname": firstname,
      "lastname": lastname,
      "email": email,
      "password": password,
      "profile": "0"
    });
    if (response['status'] == "success" &&
        response['email'] == "email send Success") {
      //sharedpref.setString("id", response['data']['id'].toString());
      Get.to(() => VerifyEmail(email: email));
    } else {
      print("signup fail");
    }
  }

  //VerifyEmail

  verifyemail(String email, String verifycode, dynamic context) async {
    update();
    var response = await _crud.postRequest(linkverifyEmail, {
      "email": email,
      "verifycode": verifycode,
    });
    if (response['status'] == "success") {
      sharedpref.setString("id", response['data']['id'].toString());
      print(response['status']);
      Get.offAll(() => const HomeView());
    } else {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
                title: Image.asset(
                  "assets/icons/wairning_icon.png",
                  width: AppConstant.screenWidth * .04,
                ),
                content: const Text("Your code is invalid Try Again"),
                actions: [
                  AppFunction.cancel(),
                ]);
          });
    }
    update();
  }
}
