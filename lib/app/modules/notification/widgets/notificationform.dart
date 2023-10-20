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
      padding: EdgeInsets.only(top: 3, bottom: 3),
      margin: EdgeInsets.only(top: 1),
      color: Colors.red,
      child: ListTile(
          title: Text(
            "${widget.body}",
            style: TextStyle(fontFamily: 'Bitter', fontSize: 15),
          ),
          trailing: IconButton(
              onPressed: () async {
                await _controller
                    .deletnotification("${widget.id_notification}");
                setState(() {});
              },
              icon: Icon(Icons.close)),
          leading: CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage(
              "https://th.bing.com/th/id/OIP.6nsKk7mIkSKvYZD_APa8-AHaFk?pid=ImgDet&rs=1",
            ),
          )),
    );
  }
}
