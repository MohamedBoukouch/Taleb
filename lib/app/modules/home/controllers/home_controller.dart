import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taleb/app/data/Crud.dart';
import 'package:taleb/app/data/const_link.dart';
import 'package:taleb/app/data/remot/testdata.dart';
import 'package:taleb/app/modules/home/views/home_view.dart';
import 'package:taleb/main.dart';
import 'package:http/http.dart' as http;


class HomeController extends GetxController {
  //TODO: Implement HomeController
  Crud _crud = Crud();
  TestData testData = TestData(Get.find());
  RxBool isLoading = true.obs;

  List<dynamic> listdata = [];
  List<dynamic> ListSliders = [];
  List<dynamic> ListActiveNotification = [];

  final count = 0.obs;
  @override
  void onInit() {
    FetchSlider();
    FirebaseMessaging.instance.subscribeToTopic("users");
    activenotification();
    activemessages();
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

  Future Showpub(String type) async {
    // statusRequest = StatusRequest.loading;
    var response = await _crud.postRequest(linkshowpubli, {
      "id_user": sharedpref.getString("id"),
      "type":type
    });
    if (response['status'] == "success") {
      print("success");
      // ListPicturesPub.assignAll(response['data']);
      // update();
      return response['data'];
    } else {
      print("error");
    }
  }

  //Addcomment
  Future<void> Addcommentaire(
      String id_user, String id_publication, String text) async {
    // int number_comt =
    //     int.tryParse(number_comment) ?? 0; // Parsing with error handling
    var response = await _crud.postRequest(linkaddcomment, {
      "id_user": id_user,
      "id_publication": id_publication,
      // "numbercomment": number_comment,
      "text": text,
    });
    if (response['status'] == "success") {
      print("Comment added successfully");
    } else {
      print(
          "Failed to add comment: ${response['message']}"); // Log error message
    }
    update(); // Assuming update() is a method to update the UI
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
      "user_id": sharedpref.getString("id"),
      "publication_id": id_publication,
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
      "publication_id": id_publication,
      "user_id": sharedpref.getString("id"),
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
      "user_id": sharedpref.getString("id"),
      "publication_id": id_publication,
    });
    if (response['status'] == "success") {
      print("is your favorit");
      // Get.rawSnackbar(
      //     title: "Notification",
      //     messageText: Text("You Are add the publication to list of favorit"));
    } else {
      print("error in favorit ");
    }
  }

  //Drop_favorit
  Dropfavorite(String id_publication) async {
    var response = await _crud.postRequest(linkDropfavorit, {
      "publication_id": id_publication,
      "user_id": sharedpref.getString("id"),
    });
    if (response['status'] == "success") {
      print("is not your favorit");
      // Get.to(FavoritView());
      // Get.rawSnackbar(
      //     title: "Notification",
      //     messageText:
      //         Text("You Are Delet the publication to list of favorit"));
    } else {
      print("error in favorit");
    }
  }

  //Search
  Search(String search_txt) async {
    var response = await _crud.postRequest(linksearch, {
      "search_txt": search_txt,
      "id_user": sharedpref.getString("id"),
    });
    if (response['status'] == "success") {
      print("Search sucssfule");
      print(response['data']);
      listdata.assignAll(response['data']);
      return response['data'];
    } else {
      print("error in search ");
    }
  }

// Future<void> Search(String searchText) async {
//   var url = Uri.parse(linksearch);

//   Map<String, String> queryParams = {
//     "search_txt": searchText,
//     "id_user": '17', // Replace with your user ID retrieval logic
//   };

//   // Build the complete URL with query parameters
//   url = Uri.https(url.authority, url.path, queryParams);

//   try {
//     final http.Response response = await http.get(
//       url,
//       headers: {
//         'Content-Type': 'application/json',
//         // Add any additional headers as needed
//       },
//     );

//     if (response.statusCode == 200) {
//       Map<String, dynamic> responseData = jsonDecode(response.body);
//       if (responseData['status'] == 'success') {
//         print("Search successful");
//         print(responseData['data']);

//         listdata.assignAll(responseData['data']);
//   //     return response['data'];
//         // Process responseData['data'] as needed
//       } else {
//         print("Error in search: ${responseData['status']}");
//         // Handle error appropriately, e.g., show error message
//       }
//     } else {
//       print("Error in search: ${response.statusCode}");
//       // Handle error appropriately, e.g., show error message
//     }
//   } catch (e) {
//     print("Exception during search: $e");
//     // Handle exception, e.g., show error message
//   }
// }
  //Active_Notification
  Future activenotification() async {
    update();
    var response = await _crud.getRequest(link_notification_active);
    // ListActiveNotification.addAll(response['data']);
    // ListNotification.assignAll(response['data']);
    if (response['status'] == "success") {
      // update();
      print(response['data']);
      return response['data'];
      
    } else {
      print("error");
      return null; // Return null or handle error accordingly
    }
  }

  //update_notification_status
  update_notification_status() async {
    update();
    var response = await _crud.postRequest(link_update_notification_status, {});
    if (response['status'] == "success") {
      print("success");
      update();
    } else {
      print("error");
      update();
    }
    update();
  }


  //Sliders
  
   FetchSlider() async {
    // statusRequest = StatusRequest.loading;
    var response = await _crud.postRequest(fetch_slider_link, {
    });
    if (response['status'] == "success") {
      print("success");
      ListSliders.assignAll(response['data']);
      isLoading.value = false;
      // update();
      // return response['data'];
    } else {
      print("error");
    }
  }

  //Message Active
    activemessages() async {
    update();
    var response = await _crud.getRequest(link_active_message);
    if (response['status'] == "success") {
      return response['data']; 
    } else {
      print("error");
      return null; // Return null or handle error accordingly
    }
  }


  //Update Status OF Message
    update_message_status() async {
    update();
    var response = await _crud.postRequest(link_update_status_message, {
      "user_id": sharedpref.getString("id"),
    });
    if (response['status'] == "success") {
      print("success");
      update();
    } else {
      print("error");
      update();
    }
    update();
  }
}
