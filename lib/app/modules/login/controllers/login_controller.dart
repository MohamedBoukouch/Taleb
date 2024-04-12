// import 'dart:js';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:taleb/app/config/constants/app_constant.dart';
import 'package:taleb/app/config/function/functions.dart';
import 'package:taleb/app/data/Crud.dart';
import 'package:taleb/app/data/const_link.dart';
import 'package:taleb/app/modules/home/views/home_view.dart';
import 'package:taleb/app/modules/login/pages/resetpassword.dart';
import 'package:taleb/app/modules/login/pages/verifycompte.dart';
import 'package:taleb/app/shared/CustomAlert.dart';
import 'package:taleb/main.dart';

class LoginController extends GetxController {
  //TODO: Implement LoginController

  Crud _crud = Crud();
  final count = 0.obs;
  @override
  void onInit() {
    // FirebaseMessaging.instance.getToken().then((Value) {
    //   String? token = Value;
    //   print(Value);
    // });
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

  login(String email, String password,dynamic context) async {
    var response = await _crud.postRequest(linklogin, {
      "email": email,
      "password": password,
    });
    if (response['status'] == "success") {
      sharedpref.setString("id", response['data']['id'].toString());
      print(response['status']);
      Get.offAll(() => const HomeView());
    } else {
      CustomAlert.show(
      context: context,
      type: AlertType.error,
      desc: 'Email Or Pasword incorrects',
      onPressed: () {
      Navigator.pop(context);
      });
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
      CustomAlert.show(
      context: context,
      type: AlertType.error,
      desc: 'Infos incorrects',
      onPressed: () {
      Navigator.pop(context);
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
      CustomAlert.show(
                          context: context,
                          type: AlertType.error,
                          desc: 'Code incorrects',
                          onPressed: () {
                            Navigator.pop(context);
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
      sharedpref.setString("id", response['data']['id'].toString());
      Get.off(() => const HomeView());
    } else {
            CustomAlert.show(
                          context: context,
                          type: AlertType.error,
                          desc: 'Information incorrects',
                          onPressed: () {
                            Navigator.pop(context);
                          });
    }
    update();
  }
}
