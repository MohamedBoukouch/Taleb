import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taleb/app/data/const_link.dart';
import 'package:taleb/app/modules/notification/controllers/notification_controller.dart';

class NotificationForm extends StatefulWidget {
  final String image;
  final String body;
  final String id_notification;
  const NotificationForm({
    Key? key,
    required this.body,
    required this.id_notification,
    required this.image,
  }) : super(key: key);

  @override
  State<NotificationForm> createState() => _NotificationFormState();
}

class _NotificationFormState extends State<NotificationForm> {
  final NotificationController controller = Get.put(NotificationController());

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
        leading: CircleAvatar(
          radius: 30,
          backgroundImage: NetworkImage(
            "$linkserverimages/publication/${widget.image}",
          ),
        ),
      ),
    );
  }
}
