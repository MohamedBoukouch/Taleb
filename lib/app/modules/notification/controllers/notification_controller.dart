import 'package:get/get.dart';
import 'package:taleb/app/data/Crud.dart';
import 'package:taleb/app/data/const_link.dart';
import 'package:taleb/app/modules/notification/views/notification_view.dart';
import 'package:taleb/main.dart';

class NotificationController extends GetxController {
  //TODO: Implement NotificationController
  Crud _crud = Crud();

  List ListNotification = [];
  final count = 0.obs;
  @override
  void onInit() {
    ListNotification;
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

  //select_notification
  Future selectnotification() async {
    // statusRequest = StatusRequest.loading;
    var response = await _crud.postRequest(link_notification, {
      "id_user": sharedpref.getString("id"),
    });
    if (response['status'] == "success") {
      print("success");
      // return
      // return ListNotification.assignAll(response['data']);
      // update();
      return response['data'];
    } else {
      print("error");
    }
  }

  //deletnotification
  Future deletnotification(String id_notification) async {
    update();
    // statusRequest = StatusRequest.loading;
    var response = await _crud.postRequest(link_delet_notification, {
      "id_notification": id_notification,
    });
    if (response['status'] == "success") {
      print("success");
      Get.to(NotificationView());
      update();
    } else {
      print("error");
      update();
    }
    update();
  }
}
