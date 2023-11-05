import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:get/get.dart';
import 'package:taleb/app/modules/notification/controllers/notification_controller.dart';
import 'package:taleb/app/modules/notification/views/notification_view.dart';

requestpermissionnotification() async {
  NotificationSettings settings =
      await FirebaseMessaging.instance.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
}

fctconfing() {
  FirebaseMessaging.onMessage.listen((message) {
    print(message.notification!.title);
    print(message.notification!.body);
    FlutterRingtonePlayer.playNotification();

    Get.snackbar(message.notification!.title!, message.notification!.body!);
    // refrechpagenotification(message.data);
  });
}

// refrechpagenotification(data) {
//   print("---------------------------------------------");
//   print(data['pageid']);
//   print(data['pagename']);
//   print(Get.currentRoute);
//   if (Get.currentRoute == "/NotificationView" &&
//       data['pagename'] == "NotificationView") {
//     // print("notification");
//     // NotificationController controller = Get.find();
//     // controller.refrechnotification();
//     // Get.to(NotificationView());
//     final NotificationController controller =
//         Get.find<NotificationController>();
//     controller.setRefreshFlag(true);
//   }
// }
