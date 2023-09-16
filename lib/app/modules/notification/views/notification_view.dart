import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:taleb/app/modules/initial/views/init_view.dart';

import '../controllers/notification_controller.dart';

class NotificationView extends GetView<NotificationController> {
  const NotificationView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return  InitialView(
      selectedindex: 1,
      body: Container(),
    );
  }
}
