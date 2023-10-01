// import 'dart:js';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:taleb/app/data/Crud.dart';
import 'package:taleb/app/data/const_lik.dart';
import 'package:taleb/app/modules/home/views/home_view.dart';

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
      print(response['status']);
      Get.to(() => const HomeView());
    } else {
      print("signup fail");
    }
  }

 
}
