import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:taleb/app/data/Crud.dart';
import 'package:taleb/app/data/const_link.dart';
import 'package:taleb/app/modules/notification/views/notification_view.dart';
import 'package:taleb/main.dart';

class NotificationController extends GetxController {
  //TODO: Implement NotificationController
  Crud _crud = Crud();

  List<dynamic> ListNotification = [];
  // List<dynamic> List_Lenght_Notification = [];
  // List<dynamic> List_notification_active = [];
  final count = 0.obs;

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;

  RxBool needsDataRefresh = true.obs;

  void setRefreshFlag(bool value) {
    needsDataRefresh.value = value;
  }

  //select_active_notification
  activenotification() async {
    update();
    var response = await _crud.getRequest(link_notification);

    update();
  }

//ALL Notifications:
  allnotifications() async {
    update();
    var response = await _crud.getRequest(link_all_notifications);
    ListNotification.addAll(response['data']);
    // ListNotification.assignAll(response['data']);
    if (response['status'] == "success") {
      print("success");

      return response['data'];
    } else {
      print("error");
    }
    update();
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

  //update_notification_status
  update_notification_status() async {
    update();
    var response = await _crud.postRequest(link_update_notification_status, {
      "active": "0",
    });
    if (response['status'] == "success") {
      print("success");
      // Get.to(NotificationView());
      update();
    } else {
      print("error");
      update();
    }
    update();
  }

  @override
  void onInit() {
    activenotification();
    ListNotification;
    super.onInit();
  }
}
