import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taleb/app/config/constants/app_constant.dart';
import 'package:taleb/app/config/function/functions.dart';
import 'package:taleb/app/data/Crud.dart';
import 'package:taleb/app/data/const_link.dart';
import 'package:taleb/main.dart';

class SettingController extends GetxController {
  //TODO: Implement SettingController

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

  //Profil
  profil() async {
    var response = await _crud.postRequest(link_profile, {
      "id_user": sharedpref.getString("id"),
    });
    if (response['status'] == "success") {
      print("Search sucssfule");
      return response['data'];
    } else {
      print("error in search ");
    }
  }

//edit compte
  edit_compte(String firstname, String lastname, String email, context) async {
    var response = await _crud.postRequest(link_edit_compte, {
      "firstname": firstname,
      "lastname": lastname,
      "email": email,
      "user_id": sharedpref.getString("id"),
    });
    if (response['status'] == "success") {
      print("edit_profile succufule");
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
                title: Image.asset(
                  "assets/icons/succefully.png",
                  width: AppConstant.screenWidth * .03,
                ),
                content: const Text(
                    "Your personal information has been changed successfully"),
                actions: [
                  AppFunction.cancel(),
                ]);
          });
    } else {
      print("error in edit text");
    }
  }

  //change password
  changepassword(String oldpassword, String newpassword, context) async {
    var response = await _crud.postRequest(link_edit_password, {
      "user_id": sharedpref.getString("id"),
      "oldpassword": oldpassword,
      "newpassword": newpassword,
    });
    if (response['status'] == "success") {
      print("edit_password sucssfule");
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
                title: Image.asset(
                  "assets/icons/succefully.png",
                  width: AppConstant.screenWidth * .02,
                ),
                content:
                    const Text("Your password has been changed Oh success"),
                actions: [
                  AppFunction.cancel(),
                ]);
          });
      //return response['data'];
    } else {
      print("error in edit password ");
      // showDialog(
      //     context: context,
      //     builder: (context) {
      //       return AlertDialog(
      //           title: Image.asset(
      //             "assets/icons/error.jpg",
      //             width: AppConstant.screenWidth * .02,
      //           ),
      //           content:
      //               const Text("Your password has been changed Oh success"),
      //           actions: [
      //             AppFunction.cancel(),
      //           ]);
      //     });
    }
  }
}
