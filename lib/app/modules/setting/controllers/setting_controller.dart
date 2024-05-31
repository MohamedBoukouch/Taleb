import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:taleb/app/config/constants/app_constant.dart';
import 'package:taleb/app/config/function/functions.dart';
import 'package:taleb/app/data/Crud.dart';
import 'package:taleb/app/data/const_link.dart';
import 'package:taleb/app/modules/login/views/login_view.dart';
import 'package:taleb/app/shared/CustomAlert.dart';
import 'package:taleb/main.dart';
import 'package:http/http.dart' as http;


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
  List<dynamic> ListEcole = [];

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
      QuickAlert.show(
        context: context,
        type: QuickAlertType.success,
        text: 'Password Changed Successfully!',
      );
      //return response['data'];
    } else {
      print("error in edit password ");
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: 'Oops...',
        text: 'Sorry, May be your password is incorrect',
      );
    }
  }

  //Delet_Compte
Future<void> deletcompte(BuildContext context) async {
    var url = Uri.parse(link_delet_compte);
    Map<String, String> data = {
      'id': sharedpref.getString("id") ?? '',
    };
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      // Add any additional headers as needed
    };

    try {
      final http.Response response = await http.delete(
        url,
        headers: headers,
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        Get.off(LoginView());
      } else {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Image.asset(
              "assets/icons/warning_icon.png",
              width: MediaQuery.of(context).size.width * 0.2,
            ),
            content: const Text("Failed to delete account"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      print("Exception during account deletion: $e");
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Image.asset(
            "assets/icons/warning_icon.png",
            width: MediaQuery.of(context).size.width * 0.2,
          ),
          content: const Text("An error occurred"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }
  // deletcompte(context) async {
  //   var response = await _crud.postRequest(link_delet_compte, {
  //     "id": sharedpref.getString("id"),
  //   });
  //   if (response['status'] == "success") {
  //     print("edit_password sucssfule");
  //     Get.off(LoginView());
  //   } else {
  //     print("error in edit password ");
  //     showDialog(
  //         context: context,
  //         builder: (context) {
  //           return AlertDialog(
  //               title: Image.asset(
  //                 "assets/icons/wairning_icon.png",
  //                 width: AppConstant.screenWidth * .02,
  //               ),
  //               content: const Text("Your password is incorrect"),
  //               actions: [
  //                 AppFunction.cancel(),
  //               ]);
  //         });
  //   }
  // }

  //Update profile
  add_pic_profile(File? _selectedImage,dynamic context) async {
    final uri = Uri.parse(link_add_pic_profile);
    var request = http.MultipartRequest('POST', uri);
    request.fields['user_id'] = "${sharedpref.getString("id")}";
    var pic =
        await http.MultipartFile.fromPath("profile", _selectedImage!.path);
    request.files.add(pic);

    if (_selectedImage != null) {
      var pic =
          await http.MultipartFile.fromPath("image", _selectedImage!.path);
      request.files.add(pic);
    }
    try {
      var response = await request.send();
      if (response.statusCode == 200) {

        CustomAlert.show(
      context: context,
      type: AlertType.success,
      desc: 'profile Update Sucssfull',
      onPressed: () {
      Navigator.pop(context);
      });

        print("Image upload successful");
      } else {
        print("Error in uploading image. Status code: ${response.statusCode}");
      }
    } catch (error) {
      print("Error sending image request: $error");
    }

    Get.back();
  }

  //Select_Ecoles
  Future selectecole(String type) async {
    var response = await _crud.postRequest(link_select_ecole, {
      "type": type,
    });
    if (response['status'] == "success") {
      return response['data'];
    } else {
      print("error");
    }
  }

  //Select_Ville_Ecoles
  Future selectvilleecole(String ecole,String type) async {
    var response = await _crud.postRequest(link_select_ville_ecole, {
      "ecole_id": ecole,
      "type": type,
    });
    if (response['status'] == "success") {
      return response['data'];
    } else {
      print("error");
    }
  }

  //Select_Pdf
  Future selectpdf(String niveau, String ecole, String ville) async {
    var response = await _crud.postRequest(link_select_pdfs, {
      "niveau": niveau,
      "ecole_id": ecole,
      "ville_id": ville,
    });
    if (response['status'] == "success") {
      return response['data'];
    } else {
      print("error");
    }
  }
}
