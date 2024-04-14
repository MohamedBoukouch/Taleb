import 'package:get/get.dart';
import 'package:taleb/app/data/Crud.dart';
import 'package:taleb/app/data/const_link.dart';
import 'package:taleb/main.dart';

class ChatController extends GetxController {
  //TODO: Implement ChatController
  Crud _crud = Crud();
  final count = 0.obs;
  List<dynamic> ListMessages = [];



  @override
  void onInit() {
    ListMessages;
    getProfileImage();
    // activemessages();
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


//getimageprofle

 String? getProfileImage() {
  // Iterate through ListMessages
  for (var message in ListMessages) {
    // Check if user_to_admin is equal to 1 and it has a profile attribute
    if (message['user_to_admin'] == 1) {
      // Return the profile image URL
      return message['profile'] as String?;
    }
  }
  // Return null if no profile image found
  return null;
}

//Send_Message
  sendmessage(String message) async {
    var response = await _crud.postRequest(link_send_messages, {
      "message": message,
      "expediteur": sharedpref.getString('id'),
      "destinataire": "1",
      "user_to_admin": "1"
    });
    if (response['status'] == "success") {
      print("send message successfull");
      // ListMessages.addAll(response['message']);
      // return response['data'];
    } else {
      print("send message fail");
    }
  }

  //show messages
  showmessage() async {
    var response = await _crud.postRequest(
        link_show_messages, {"id_user": sharedpref.getString('id')});
    if (response['status'] == "success") {
      print("show messages sucssfull");
      ListMessages.addAll(response['data']);
      return response['data'];
    } else {
      print("show messages fail");
    }
  }

  //delet_message
  delet_message(String id_message) async {
    var response =
        await _crud.postRequest(link_delet_message, {"id_message": id_message});
    if (response['status'] == "success") {
      print("messages deleted sucssfull");
      // ListMessages.addAll(response['data']);
      // return response['data'];
    } else {
      print("show messages fail");
    }
  }

  //Active Notification

}
