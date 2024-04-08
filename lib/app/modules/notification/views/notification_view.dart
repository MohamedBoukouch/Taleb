import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:get/get.dart';
import 'package:taleb/app/config/constants/app_constant.dart';
import 'package:taleb/app/config/images/app_images.dart';
import 'package:taleb/app/modules/notification/widgets/notificationform.dart';

import '../../home/pages/see_all.dart';
import '../controllers/notification_controller.dart';

class NotificationView extends GetView<NotificationController> {
  NotificationView({Key? key}) : super(key: key);
  final NotificationController _controller = Get.put(NotificationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Notifications'.tr,
          style: TextStyle(fontFamily: 'Bitter'),
        ),
      ),
      body: FutureBuilder(
              future: _controller.allnotifications(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: SpinKitCircle(
                      color: Color.fromARGB(255, 246, 154, 7),
                      size: 60,
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Image.asset(
                      Appimages.error,
                      width: AppConstant.screenWidth * .8,
                    ),
                  );
                } else if (!snapshot.hasData) {
                  return const Center(
                    child: Center(child: Text("No data available")),
                  );
                } else {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return Dismissible(
                        key: Key("${snapshot.data[index]['id']}"),
                        direction: DismissDirection.startToEnd,
                        background: const Card(
                          color: Color.fromARGB(255, 255, 34, 0),
                          child: Icon(
                            Icons.delete,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                        onDismissed: (direction) {
                          _controller.deletnotification(
                              "${snapshot.data[index]['id']}");
                        },
                        child: InkWell(
                          onTap: () => Get.to(()=>SeeAll(type: "${controller.ListNotification[index]['id_publication']}")),
                          child: NotificationForm(
                              image: "${snapshot.data[index]['image']}",
                              body: "${snapshot.data[index]['body']}",
                              id_notification: "${snapshot.data[index]['id']}"),
                        ),
                      );
                    },
                  );
                }
              },
            )
    );
  }
}