import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart'; // Import Flutter Material package
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:taleb/app/config/constants/app_constant.dart';
import 'package:taleb/app/config/function/checkInternet.dart';
import 'package:taleb/app/config/images/app_images.dart';
import 'package:taleb/app/data/const_link.dart';
import 'package:taleb/app/modules/chat/views/chat_view.dart';
import 'package:taleb/app/modules/home/controllers/home_controller.dart';
import 'package:taleb/app/modules/home/widgets/appbar.dart';
import 'package:taleb/app/modules/notification/controllers/notification_controller.dart';
import 'package:taleb/app/modules/notification/views/notification_view.dart';
import 'package:taleb/app/shared/publication.dart';
import 'package:taleb/app/modules/home/widgets/slider.dart';
import 'package:taleb/app/modules/initial/views/init_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final HomeController controller = Get.put(HomeController());
  final NotificationController controller_notification =
      Get.put(NotificationController());

  // final FavoriController favorit_controller = Get.put(FavoriController());

  var res;

  initialdata() async {
    res = await chekInternet();
    print(res);
  }

  @override
  void initState() {
    initialdata();
    setState(() {
      // splitString();
    });
    // controller.Showpub();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InitialView(
      selectedindex: 3,
      appbar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Taleb',
          style: TextStyle(
            color: Colors.black, // Text color
          ),
        ),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: Icon(Icons.notifications, size: 30),
                onPressed: () async {
                  print(
                      "${await controller_notification.ListNotification.length}");

                  try {
                    await controller_notification.update_notification_status();
                  } catch (e) {
                    print(e);
                  }
                  Get.to(NotificationView());
                },
                color: Color.fromARGB(214, 112, 111, 111),
              ),

              Positioned(
                bottom: 5,
                right: 18,
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10)),
                  // child: Center(
                  //   child: Text(
                  //       "${controller_notification.ListNotification.length}"),
                  // ),
                ),
              )
              // : Positioned(child: Text("")),
            ],
          ),
          IconButton(
            icon: Icon(Icons.chat_bubble_outline_outlined, size: 30),
            onPressed: () async {
              Get.to(ChatView());
            },
            color: Color.fromARGB(214, 112, 111, 111),
          ),
        ],
      ),
      body: ListView(
        children: [
          Slidere(),
          FutureBuilder(
            future: controller.Showpub(),
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
                    return PostCard(
                      link: "${snapshot.data[index]['link']}",
                      is_liked: snapshot.data[index]['liked'],
                      is_favorit: snapshot.data[index]['favorite'],
                      numberlike: snapshot.data[index]['numberlike'],
                      numbercomment: snapshot.data[index]['numbercomment'],
                      id_publication: "${snapshot.data[index]['id']}",
                      // forcomment: false,
                      localisation: " ${snapshot.data[index]['localisation']}",
                      timeAgo: "  ${snapshot.data[index]['date']}",
                      titel: "${snapshot.data[index]['titel']}",
                      description: "${snapshot.data[index]['description']}",
                      postImage: "${snapshot.data[index]['file']}",
                      // postImage:
                      //     "$linkservername/publication/upload/${snapshot.data[index]['file']}",
                    );
                  },
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
