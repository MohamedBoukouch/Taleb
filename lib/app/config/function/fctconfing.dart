import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:get/get.dart';

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
  });
}
