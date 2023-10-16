// import 'dart:js';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taleb/app/config/constants/app_constant.dart';
import 'package:taleb/app/config/function/functions.dart';
import 'package:taleb/app/data/Crud.dart';
import 'package:taleb/app/data/const_link.dart';
import 'package:taleb/app/modules/home/views/home_view.dart';
import 'package:taleb/app/modules/login/pages/resetpassword.dart';
import 'package:taleb/app/modules/login/pages/verifycompte.dart';
import 'package:taleb/main.dart';

class LoginController extends GetxController {
  //TODO: Implement LoginController

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

  login(String email, String password) async {
    var response = await _crud.postRequest(linklogin, {
      "email": email,
      "password": password,
    });
    if (response['status'] == "success") {
      sharedpref.setString("id", response['data']['id'].toString());
      print(response['status']);
      Get.to(() => const HomeView());
    } else {
      print("signup fail");
    }
  }

  //checkEmail
  checkemail(String email, dynamic context) async {
    var response = await _crud.postRequest(linkcheckEmail, {
      "email": email,
    });
    if (response['status'] == "success") {
      print(response['status']);
      Get.to(() => VerifyCompte(
            email: email,
          ));
    } else {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
                title: Image.asset(
                  "assets/icons/wairning_icon.png",
                  width: AppConstant.screenWidth * .04,
                ),
                content: const Text("This mail does not exist"),
                actions: [
                  AppFunction.cancel(),
                ]);
          });
    }
  }

  //VerifyCompte

  verifycompte(String email, String verifycode, dynamic context) async {
    update();
    var response = await _crud.postRequest(linkverifycompte, {
      "email": email,
      "verifycode": verifycode,
    });
    if (response['status'] == "success") {
      Get.to(() => ResetPassword(
            email: email,
          ));
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

  //Restpassword
  resetpassword(String email, String password, dynamic context) async {
    var response = await _crud.postRequest(linkresertpassword, {
      "email": email,
      "password": password,
    });
    if (response['status'] == "success") {
      Get.to(() => const HomeView());
    } else {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
                title: Image.asset(
                  "assets/icons/wairning_icon.png",
                  width: AppConstant.screenWidth * .04,
                ),
                content: const Text("Erro 404 Try again"),
                actions: [
                  AppFunction.cancel(),
                ]);
          });
    }
    update();
  }
}
