import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taleb/app/config/constants/app_constant.dart';
import 'package:taleb/app/config/function/functions.dart';
import 'package:taleb/app/data/Crud.dart';
import 'package:taleb/app/data/const_link.dart';
import 'package:taleb/app/data/remot/testdata.dart';
import 'package:taleb/app/modules/home/pages/commentaires.dart';
import 'package:taleb/app/modules/home/views/home_view.dart';
import 'package:taleb/app/modules/home/widgets/publication.dart';
import 'package:taleb/app/modules/login/views/login_view.dart';
import 'package:taleb/main.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController
  Crud _crud = Crud();
  TestData testData = TestData(Get.find());

  List data = [];
  // late StatusRequest statusRequest;

  // getData() async {
  //   // statusRequest = StatusRequest.loading;
  //   var response = await testData.getData();
  // statusRequest = handlingData(response);
  //   // if (StatusRequest.success == statusRequest) {
  //     data.addAll(response);
  //   // }
  //   update();
  //   @override
  //   onInit() {
  //     getData();
  //     super.onInit();
  //   }
  // }

  final count = 0.obs;
  @override
  void onInit() {
    // Showpub();
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

  Future Showpub() async {
    // statusRequest = StatusRequest.loading;
    var response = await _crud.postRequest(linkshowpubli, {
      "id_user": sharedpref.getString("id"),
    });
    if (response['status'] == "success") {
      print("success");
      // update();
      return response['data'];
    } else {
      print("error");
    }
  }

  //Addcomment
  Addcommentaire(String id_user, String id_publication, String text,
      String number_comment) async {
    int number_comt = int.parse(number_comment);
    var response = await _crud.postRequest(linkaddcomment, {
      "id_user": id_user,
      "id_publication": id_publication,
      "numbercomment": number_comment,
      "text": text,
    });
    if (response['status'] == "success") {
      print("coment add successfull");
    } else {
      print("signup fail");
    }
    update();
  }

  //Showcomment
  Showcomment(String id_publication) async {
    var response = await _crud.postRequest(linkshowcomment, {
      "id_publication": id_publication,
    });
    if (response['status'] == "success") {
      print("show comment successfull");
      return response['data'];
    } else {
      print("signup fail");
    }
  }

  // Detel_comment
  Deletcomment(String id_comment, String id_publication, String numbercomment,
      context) async {
    var nb_comment = int.parse(numbercomment);
    assert(nb_comment is int);

    var response = await _crud.postRequest(linkdeletcomment, {
      "id_comment": id_comment,
      "id_publication": id_publication,
      "numbercomment": numbercomment,
    });
    if (response['status'] == "success") {
      print("comment delete succeful => ${nb_comment}");
      // Get.back();
      Get.to(HomeView());
      // Get.off(Commentaire(id_publication: id_publication, number_comment: 17));
    } else {
      print("Error in delet a comment");
    }
  }

  //AddLike
  Addlike(String id_publication, String numberlike) async {
    var response = await _crud.postRequest(linkAddlike, {
      "id_user": sharedpref.getString("id"),
      "id_publication": id_publication,
    });
    if (response['status'] == "success") {
      print("you like publiaction");
      var response = await _crud.postRequest(linkLike, {
        "numberlike": numberlike,
        "id_publication": id_publication,
      });
    } else {
      print("error in like ");
    }
  }

  //DropLike
  Droplike(String id_publication, String numberlike) async {
    var response = await _crud.postRequest(linkDroplike, {
      "id_publication": id_publication,
      "id_user": sharedpref.getString("id"),
    });
    if (response['status'] == "success") {
      print("u are drop like");
      var response = await _crud.postRequest(linkLike, {
        "numberlike": numberlike,
        "id_publication": id_publication,
      });
    } else {
      print("error in drop like");
    }
  }

  //Add_favorit
  Addfavorite(String id_publication) async {
    var response = await _crud.postRequest(linkAddfavorit, {
      "id_user": sharedpref.getString("id"),
      "id_publication": id_publication,
    });
    if (response['status'] == "success") {
      print("is your favorit");
      Get.rawSnackbar(
          title: "Notification",
          messageText: Text("You Are add the publication to list of favorit"));
    } else {
      print("error in favorit ");
    }
  }

  //Drop_favorit
  Dropfavorite(String id_publication) async {
    var response = await _crud.postRequest(linkDropfavorit, {
      "id_publication": id_publication,
      "id_user": sharedpref.getString("id"),
    });
    if (response['status'] == "success") {
      print("is not your favorit");
      Get.rawSnackbar(
          title: "Notification",
          messageText:
              Text("You Are Delet the publication to list of favorit"));
    } else {
      print("error in favorit");
    }
  }
}
