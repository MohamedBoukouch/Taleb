import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taleb/app/modules/notification/controllers/notification_controller.dart';

class NotificationForm extends StatefulWidget {
  final String body;
  final int id_notification;
  const NotificationForm({
    Key? key,
    required this.body,
    required this.id_notification,
  }) : super(key: key);

  @override
  State<NotificationForm> createState() => _NotificationFormState();
}

class _NotificationFormState extends State<NotificationForm> {
  final NotificationController _controller = Get.put(NotificationController());

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 5, bottom: 5),
      margin: EdgeInsets.only(top: 1),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Color.fromARGB(20, 158, 158, 158),
      ),
      child: ListTile(
        title: Text(
          "${widget.body}",
          style: TextStyle(fontFamily: 'Bitter', fontSize: 15),
        ),
        leading: const CircleAvatar(
          radius: 30,
          backgroundImage: NetworkImage(
            "https://th.bing.com/th/id/OIP.6nsKk7mIkSKvYZD_APa8-AHaFk?pid=ImgDet&rs=1",
          ),
        ),
      ),
    );
  }
}
