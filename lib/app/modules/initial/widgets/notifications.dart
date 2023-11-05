import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taleb/app/modules/initial/controllers/init_controller.dart';
import 'package:taleb/app/modules/notification/controllers/notification_controller.dart';
import 'package:taleb/app/modules/notification/views/notification_view.dart';

class NotificationIcon extends StatefulWidget {
  final int not;
  const NotificationIcon({Key? key, required this.not}) : super(key: key);

  @override
  State<NotificationIcon> createState() => _NotificationIconState();
}

class _NotificationIconState extends State<NotificationIcon> {
  final InitController controller = Get.put(InitController());
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IconButton(
          icon: Icon(Icons.notifications, size: 30),
          onPressed: () async {
            print("${widget.not}");
            // await Get.to(NotificationView());
            // controller.ListNotification.clear();
          },
          color: Color.fromARGB(214, 112, 111, 111),
        ),
        controller.List_Active_Notification.length > 0
            ? Positioned(
                bottom: 31,
                right: 13,
                child: Container(
                  width: 11,
                  height: 11,
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(50)),
                ),
              )
            : Container()
      ],
    );
  }
}
