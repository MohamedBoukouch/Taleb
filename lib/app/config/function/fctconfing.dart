import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

Future<void> requestpermissionnotification() async {
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

void fctconfing() {
  FirebaseMessaging.onMessage.listen((message) {
    print(message.notification!.title);
    print(message.notification!.body);
    // FlutterRingtonePlayer.playNotification();

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
